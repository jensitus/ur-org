require 'sidekiq'

Sidekiq::Extensions.enable_delay!

Sidekiq.configure_client do |config|
  config.redis = { size: 3, url: ENV["REDIS_PROVIDER"] }
  # config.redis = { url: 'redis://localhost:6379' }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_PROVIDER"]}
  # config.redis = { url: 'redis://localhost:6379' }
end
