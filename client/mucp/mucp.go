// Package mucp provides an mucp client
package mucp

import (
	"github.com/go-micro/microwire/v5/client"
	"github.com/go-micro/microwire/v5/util/cmd"
)

func init() {
	cmd.DefaultClients["mucp"] = NewClient
}

// NewClient returns a new micro client interface
func NewClient(opts ...client.Option) client.Client {
	return client.NewClient(opts...)
}
