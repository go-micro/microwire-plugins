package grpc

import (
	"context"

	"github.com/go-micro/microwire/v5/server"
)

func setServerOption(k, v interface{}) server.Option {
	return func(o *server.Options) {
		if o.Context == nil {
			o.Context = context.Background()
		}
		o.Context = context.WithValue(o.Context, k, v)
	}
}
