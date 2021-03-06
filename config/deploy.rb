lock "~> 3.16.0"

set :application, "apps.varland.com"
set :repo_url, "git@github.com:tobyvarland/apps.varland.com.git"

set :deploy_to, "/home/varland/#{fetch :application}"

append :linked_dirs, 'storage', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'tmp/pdfs', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'
append :linked_files, 'config/master.key'
set :keep_releases, 5

# after :"passenger:restart", :restart_sidekiq

# task :restart_sidekiq do
#   on roles(:app) do
#     execute "systemctl restart sidekiq-apps"
#   end
# end