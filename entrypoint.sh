#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# Run database migrations
# The migration command will fail with ActiveRecord::ConcurrentMigrationError
# if another process is already running migrations. We can ignore this error
# and proceed, as it means migrations are being handled.
bundle exec rails db:migrate || true

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"