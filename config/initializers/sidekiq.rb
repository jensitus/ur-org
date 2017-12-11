require 'sidekiq'

Sidekiq::Extensions.enable_delay!

Sidekiq.configure_client do |config|
  config.redis = { size: 3, url: ENV["REDIS_URL"], namespace: "receta" }
end