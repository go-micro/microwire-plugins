package defaults

import (
	_ "github.com/go-micro/microwire-plugins/broker/http/v5"
	_ "github.com/go-micro/microwire-plugins/cli/urfave/v5"
	_ "github.com/go-micro/microwire-plugins/codec/grpc/v5"
	_ "github.com/go-micro/microwire-plugins/codec/json/v5"
	_ "github.com/go-micro/microwire-plugins/codec/jsonrpc/v5"
	_ "github.com/go-micro/microwire-plugins/codec/proto/v5"
	_ "github.com/go-micro/microwire-plugins/codec/protorpc/v5"
	_ "github.com/go-micro/microwire-plugins/codec/text/v5"
	_ "github.com/go-micro/microwire-plugins/registry/mdns/v5"
	_ "github.com/go-micro/microwire-plugins/transport/http/v5"
)
