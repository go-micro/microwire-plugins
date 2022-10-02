# MQTT Broker

The MQTT broker is useful for IoT based applications

## Usage

Drop in import

```go
import _ "github.com/go-micro/microwire-plugins/broker/mqtt/v5"
```

Flag on command line

```shell
go run main.go --broker=mqtt
```

Alternatively use directly

```go
import (
	"go-micro.dev/v4"
	"github.com/go-micro/microwire-plugins/broker/mqtt/v5"
)


func main() {
	service := micro.NewService(
		micro.Name("my.service"),
		micro.Broker(mqtt.NewBroker()),
	)
}
```

## Encoding

Because MQTT does not support message headers the plugin encodes messages using JSON. 
If you prefer to send and receive the mqtt payload uninterpreted use the `noop` codec.

Example

```go
import (
    "github.com/micro/broker"
    "github.com/micro/broker/codec/noop"
    "github.com/go-micro/microwire-plugins/broker/mqtt/v5"
)

b := mqtt.NewBroker(
    broker.Codec(noop.NewCodec()),
)
```
