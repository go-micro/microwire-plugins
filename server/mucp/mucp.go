// Package mucp provides an mucp server
package mucp

import (
	"github.com/go-micro/microwire/v5/server"
	"github.com/go-micro/microwire/v5/util/cmd"
)

func init() {
	cmd.DefaultServers["mucp"] = NewServer
}

// NewServer returns a micro server interface
func NewServer(opts ...server.Option) server.Server {
	return server.NewServer(opts...)
}
