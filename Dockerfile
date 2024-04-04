# Use the official golang image as base
FROM golang:latest AS builder

# Set necessary environment variables
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Create and set the working directory
WORKDIR /app

# Copy the code into the container
COPY . .

# Build the Go app
RUN go mod download && \
    go build -o main .

# Start a new stage from scratch
FROM alpine:latest

# Set necessary environment variables
ENV PORT=3030

# Copy the compiled binary from the builder stage to the new stage
COPY --from=builder /app/main /app/main

# Expose port 3030 to the outside world
EXPOSE $PORT

# Command to run the executable with default flags
# CMD ["/app/main"]

# Optionally, you can allow passing flags to the executable
CMD ["/app/main", "-port", "3030", "-backends", "backend1,backend2"]
