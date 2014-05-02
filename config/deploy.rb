# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'basic'
set :repo_url, 'https://github.com/Mikeyheu/basic.git'

# rbenv configuration
set :rbenv_type, :user
set :rbenv_ruby, '2.1.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :ssh_options, { forward_agent: true }

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :rails do
  desc "Open the rails console on each of the remote servers"
  task :console do
    on roles(:app), :primary => true do
      rails_env = fetch(:stage)
      execute_interactively "ruby #{current_path}/script/rails console #{rails_env}"  
    end
  end
 
  # desc "Open the rails dbconsole on each of the remote servers"
  # task :dbconsole do
  #   on roles(:db) do |host| #does it for each host, bad.
  #     rails_env = fetch(:stage)
  #     execute_interactively "ruby #{current_path}/script/rails dbconsole #{rails_env}"  
  #   end
  # end
 
  def execute_interactively(command)
    user = fetch(:user)
    port = fetch(:port) || 22
    exec "ssh -l #{user} #{host} -p #{port} -t 'cd #{deploy_to}/current && #{command}'"
  end
end