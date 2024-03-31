package main

import (
	"flag"
	"fmt"
	"net/http/httputil"
	"net/url"
	"sync"
)

type Backend struct {
	URL          *url.URL
	Alive        bool
	mux          sync.RWMutex
	ReverseProxy *httputil.ReverseProxy
}

type ServerPool struct {
	backends []*Backend
	current  uint64
}

func main() {
	var port int
	flag.IntVar(&port, "port", 3030, "Port to Serve")
	flag.Parse()
	fmt.Println("A simple load-balancer implementiaiton in golang on port:- ", port)
}
