require 'sidekiq'
require 'sidekiq-status'

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes # default
  end
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end

if Rails.env =="production"
  Sidekiq.configure_server do |config|
    config.redis = { :url => 'redis://ec2-54-187-54-142.us-west-2.compute.amazonaws.com:6379', :namespace => 'namespace' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { :url => 'redis://ec2-54-187-54-142.us-west-2.compute.amazonaws.com:6379', :namespace => 'namespace' }
  end
end


