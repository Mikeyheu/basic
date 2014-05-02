set :stage, :production
set :branch, 'master'

server "54.187.158.134", user: 'deployer', roles: %w{web app db worker}, primary: true
# server "54.187.54.142", user: 'deployer', roles: %w{web app worker}
set :deploy_to, '/home/deployer/apps/basic'
set :rails_env, :production

set :enable_ssl, false