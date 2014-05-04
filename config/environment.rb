# Load the Rails application.
require File.expand_path('../application', __FILE__)


  env_file = File.join(Rails.root, 'config', 'local_env.yml')
  if File.exists?(env_file)
    puts "IT EXISTS!!!"
    YAML.load_file(env_file)[Rails.env].to_hash.each do |key, value|
      ENV[key.to_s] = value
    end 
  end

# Initialize the Rails application.
Basic::Application.initialize!
