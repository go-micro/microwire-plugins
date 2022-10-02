// Package registry uses the go-micro registry for selection
package registry

import (
	"github.com/go-micro/microwire/v5/selector"
	"github.com/go-micro/microwire/v5/util/cmd"
)

func init() {
	cmd.DefaultSelectors["registry"] = NewSelector
}

// NewSelector returns a new registry selector
func NewSelector(opts ...selector.Option) selector.Selector {
	return selector.NewSelector(opts...)
}
