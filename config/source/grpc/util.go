package grpc

import (
	"time"

	proto "github.com/go-micro/microwire-plugins/config/source/grpc/v5/proto"
	"github.com/go-micro/microwire/v5/config/source"
)

func toChangeSet(c *proto.ChangeSet) *source.ChangeSet {
	return &source.ChangeSet{
		Data:      c.Data,
		Checksum:  c.Checksum,
		Format:    c.Format,
		Timestamp: time.Unix(c.Timestamp, 0),
		Source:    c.Source,
	}
}
