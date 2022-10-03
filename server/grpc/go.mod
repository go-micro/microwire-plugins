module github.com/go-micro/microwire-plugins/server/grpc

go 1.18

replace (
	github.com/go-micro/plugins/v4/client/grpc => ../../client/grpc
	github.com/go-micro/plugins/v4/transport/grpc => ../../transport/grpc
)
