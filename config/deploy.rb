require 'pg_search'
# config valid only for current version of Capistrano
lock '3.10.1'

set :application, 'receta' # 'my_app_name'
set :repo_url, 'https://github.com/jensitus/ur-org.git'

set :puma_threads, [4, 16]
set :puma_workers, 0

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/jens/receta'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

set :use_sudo, false

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

set :puma_bind, "unix:///home/jens/receta/shared/tmp/sockets/receta-puma.sock"
set :puma_state, "home/jens/receta/shared/tmp/pids/puma.state"
set :puma_pid, "home/jens/receta/shared/tmp/pids/puma.pid"
# set :puma_access_log, "#{release_path}/log/puma.error.log"
# set :puma_error_log, "#{release_path}/log/puma.puma.access.log"
set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true



# Default value for :linked_files is []
set :linked_files, %w{config/database.yml} #fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system} # fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
#set :default_env, { path: '~/.rvm/bin/rvm' }  # { path: "/opt/ruby/bin:$PATH" }
#set :stage, :production
#set :rails_env, 'production'

# Default value for keep_releases is 5
# set :keep_releases, 5

# # # # # # # # # # # # # # # #
namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir home/jens/receta/shared/tmp/sockets -p"
      execute "mkdir home/jens/receta/shared/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end
# # # # # # # # # # # # # # # #

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # execute :touch, release_path.join('tmp/restart.txt')
      invoke 'puma:restart'
    end
  end
  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end
  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'

end

# the sidekiq
namespace :sidekiq do
  task :quiet do
    on roles(:app) do
      # Horrible hack to get PID without having to use terrible PID files
      puts capture("kill -USR1 $(sudo initctl status workers | grep /running | awk '{print $NF}') || :")
    end
  end
  task :restart do
    on roles(:app) do
      execute :sudo, :initctl, :restart, :workers
    end
  end
end

after 'deploy:starting', 'sidekiq:quiet'
after 'deploy:reverted', 'sidekiq:restart'
after 'deploy:published', 'sidekiq:restart'

# namespace :adm do
#   task :sake do
#     on roles(:app) do
#       within "#{current_path}" do
#         with rails_env: :production do
#           execute :rake, 'admin:the_user'
#         end
#       end
#     end
#   end
# end
#
# after 'deploy:published', 'adm:sake'

# the search
# namespace :pgs do
#   desc 'Invoke pg_search task'
#   task :invoke do
#     on roles(:app) do
#       within "#{current_path}" do
#         with rails_env: :production do
#           execute :rake, 'pg_search:multisearch:rebuild[Micropost]'
#         end
#       end
#     end
#   end
# end
#
# after 'deploy:published', 'pgs:invoke'
