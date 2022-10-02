// Package mucp provides an mucp server
package mucp

import (
	"github.com/go-micro/microwire/v5/server"
)

func init() {
	server.Plugins.Add("mucp", NewServer)
}

// NewServer returns a micro server interface
func NewServer(opts ...server.Option) server.Server {
	return server.NewServer(opts...)
}
