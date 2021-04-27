lock "~> 3.16.0"

set :application, "apps.varland.com"
set :repo_url, "git@github.com:tobyvarland/apps.varland.com.git"

set :deploy_to, "/home/varland/#{fetch :application}"

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'
append :linked_files, 'config/master.key'
set :keep_releases, 5