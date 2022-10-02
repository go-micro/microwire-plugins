// Package http returns a http2 transport using net/http
package http

import (
	"github.com/go-micro/microwire/v5/transport"
)

func init() {
	_ = transport.Plugins.Add("http", NewTransport)
}

// NewTransport returns a new http transport using net/http and supporting http2
func NewTransport(opts ...transport.Option) transport.Transport {
	return transport.NewHTTPTransport(opts...)
}
