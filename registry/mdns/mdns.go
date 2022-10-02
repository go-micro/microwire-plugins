// Package mdns provides a multicast dns registry
package mdns

import (
	"github.com/go-micro/microwire/v5/registry"
	"github.com/go-micro/microwire/v5/util/cmd"
)

func init() {
	cmd.DefaultRegistries["mdns"] = NewRegistry
}

// NewRegistry returns a new mdns registry
func NewRegistry(opts ...registry.Option) registry.Registry {
	return registry.NewRegistry(opts...)
}
