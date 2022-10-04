// Package json provides a json codec
package json

import (
	"encoding/json"
	"io"

	"github.com/go-micro/microwire/v5/codec"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

func init() {
	_ = codec.Plugins.Add("json", NewCodec)
}

type Codec struct {
	Conn    io.ReadWriteCloser
	Encoder *json.Encoder
	Decoder *json.Decoder
}

func (c *Codec) ReadHeader(m *codec.Message, t codec.MessageType) error {
	return nil
}

func (c *Codec) ReadBody(b interface{}) error {
	if b == nil {
		return nil
	}
	if pb, ok := b.(proto.Message); ok {
		return unmarshalNext(c.Decoder, pb)
	}
	return c.Decoder.Decode(b)
}

func (c *Codec) Write(m *codec.Message, b interface{}) error {
	if b == nil {
		return nil
	}
	return c.Encoder.Encode(b)
}

func (c *Codec) Close() error {
	return c.Conn.Close()
}

func (c *Codec) String() string {
	return "json"
}

func NewCodec(c io.ReadWriteCloser) codec.Codec {
	return &Codec{
		Conn:    c,
		Decoder: json.NewDecoder(c),
		Encoder: json.NewEncoder(c),
	}
}

// https://github.com/golang/protobuf/issues/1231#issuecomment-715664100
func unmarshalNext(d *json.Decoder, m proto.Message) error {
	var b json.RawMessage
	if err := d.Decode(&b); err != nil {
		return err
	}
	return protojson.Unmarshal(b, m)
}
