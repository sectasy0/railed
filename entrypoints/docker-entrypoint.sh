#!/bin/sh

set -e

# Create database if it doesn't exist
if ! bundle exec rails db:exists; then
  bundle exec rails db:create
  bundle exec rails db:schema:load
fi

# There is no need to run rails server during test
if [ "$RAILS_ENV" = "test" ]; then
  tail -f /dev/null
  exit 0
fi

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

crond -L $APP_DIR/log/cron.log -b
syslogd -n -O $APP_DIR/log/syslog.log &

RAILS_SERVE_STATIC_FILES=1 RUBYOPT="--yjit" bundle exec rails s -b 0.0.0.0 -p 7777
