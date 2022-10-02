package file

import (
	"context"

	"github.com/go-micro/microwire/v5/store"
)

type dirOptionKey struct{}

// DirOption is a file store Option to set the directory for the file store
func DirOption(dir string) store.Option {
	return func(o *store.Options) {
		if o.Context == nil {
			o.Context = context.Background()
		}
		o.Context = context.WithValue(o.Context, dirOptionKey{}, dir)
	}
}
