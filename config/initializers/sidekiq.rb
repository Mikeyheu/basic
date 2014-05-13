require 'sidekiq'

if Rails.env =="production"
  Sidekiq.configure_server do |config|
    # config.redis = { :url => 'redis://ec2-54-187-158-134.us-west-2.compute.amazonaws.com:6379', :namespace => 'namespace' }
    config.redis = { :url => "redis://:#{ENV['REDISCLOUD_PASSWORD']}@#{ENV['REDISCLOUD_URL']}", :namespace => 'namespace' }
  end

  Sidekiq.configure_client do |config|
    # config.redis = { :url => 'redis://ec2-54-187-158-134.us-west-2.compute.amazonaws.com:6379', :namespace => 'namespace' }
    # config.redis = { :url => ENV['REDISCLOUD_URL'], :namespace => 'namespace', :password => ENV['REDISCLOUD_PASSWORD'] }

    config.redis = { :url => "redis://:#{ENV['REDISCLOUD_PASSWORD']}@#{ENV['REDISCLOUD_URL']}", :namespace => 'namespace' }
  end
end

