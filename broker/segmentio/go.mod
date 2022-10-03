module github.com/go-micro/microwire-plugins/broker/segmentio

go 1.18

replace (
	github.com/go-micro/plugins/v4/broker/kafka => ../kafka
	github.com/go-micro/plugins/v4/codec/segmentio => ../../codec/segmentio
)
