// Package mucp provides an mucp client
package mucp

import (
	"github.com/go-micro/microwire/v5/client"
)

func init() {
	_ = client.Plugins.Add("mucp", NewClient)
}

// NewClient returns a new micro client interface
func NewClient(opts ...client.Option) client.Client {
	return client.NewClient(opts...)
}
