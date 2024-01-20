# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { host: ENV.fetch('REDIS_HOST'), port: ENV.fetch('REDIS_PORT', 6379) }
end

Sidekiq.configure_client do |config|
  config.redis = { host: ENV.fetch('REDIS_HOST'), port: ENV.fetch('REDIS_PORT', 6379) }
end
