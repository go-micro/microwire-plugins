// Package mdns provides a multicast dns registry
package mdns

import (
	"github.com/go-micro/microwire/v5/registry"
)

func init() {
	registry.Plugins.Add("mdns", NewRegistry)
}

// NewRegistry returns a new mdns registry
func NewRegistry(opts ...registry.Option) registry.Registry {
	return registry.NewRegistry(opts...)
}
