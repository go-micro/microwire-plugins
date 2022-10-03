package nats

import (
	_ "github.com/go-micro/microwire-plugins/broker/nats/v5"
	_ "github.com/go-micro/microwire-plugins/cli/urfave/v5"
	_ "github.com/go-micro/microwire-plugins/events/nats/v5"
	_ "github.com/go-micro/microwire-plugins/registry/nats/v5"
	_ "github.com/go-micro/microwire-plugins/transport/nats/v5"
)
