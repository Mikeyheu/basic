Sidekiq.configure_server do |config|
  config.redis = { :url => 'redis://ec2-54-187-54-142.us-west-2.compute.amazonaws.com:6379', :namespace => 'namespace' }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => 'redis://ec2-54-187-54-142.us-west-2.compute.amazonaws.com:6379', :namespace => 'namespace' }
end