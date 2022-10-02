package cache

import (
	"time"

	"github.com/go-micro/microwire/v5/registry/cache"
)

// WithTTL sets the cache TTL
func WithTTL(t time.Duration) cache.Option {
	return cache.WithTTL(t)
}
