# config/initializers/redis.rb
require "redis"

# global constant
REDIS = Redis.new(
  host: ENV.fetch("REDIS_HOST", "127.0.0.1"),
  port: ENV.fetch("REDIS_PORT", 6379),
  db: ENV.fetch("REDIS_DB", 0)
)

APPLICATION_LIST_CACHE_KEY = "applications"
CHATS_LIST_CACHE_KEY = "application:{token}:chats"
Messages_LIST_CACHE_KEY = "application:{token}:chat:{number}:messages"

