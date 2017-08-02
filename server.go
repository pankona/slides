package main

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, r.URL.Path[1:])
}

func main() {
	port := 8080
	http.HandleFunc("/", handler)
	fmt.Printf("server will running on port: %d\n", port)
	http.ListenAndServe(fmt.Sprintf(":%d", port), nil)
}
