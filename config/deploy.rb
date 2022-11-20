lock "~> 3.16.0"

set :application, "apps.varland.com"
set :repo_url, "git@github.com:tobyvarland/apps.varland.com.git"

set :deploy_to, "/Users/varland/rails_apps/#{fetch :application}"

append :linked_dirs, 'storage', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'tmp/pdfs', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'
append :linked_files, 'config/master.key'
set :keep_releases, 5

task :restart_sidekiq do
  on roles(:app) do
    execute "sudo service sidekiq-apps restart"
  end
end

set :default_env, {
  path: "$HOME/.nvm/versions/node/v14.21.1/bin/" # this will add "$HOME/nodejs/bin" into PATH environment variable during Capistrano command execution
}

#after :"passenger:restart", :restart_sidekiq

# namespace :nvm do
#   namespace :webpacker do
#     task :validate => [:'nvm:map_bins'] do
#       on release_roles(fetch(:nvm_roles)) do
#         within release_path do
#           if !test('node', '--version')
#             warn "node is not installed"
#             exit 1
#           end

#           if !test('yarn', '--version')
#             warn "yarn is not installed"
#             exit 1
#           end
#         end
#       end
#     end

#     task :wrap => [:'nvm:map_bins'] do
#       on roles(:web) do
#         SSHKit.config.command_map.prefix['rake'].unshift(nvm_prefix)
#       end
#     end

#     task :unwrap do
#       on roles(:web) do
#         SSHKit.config.command_map.prefix['rake'].delete(nvm_prefix)
#       end
#     end

#     def nvm_prefix
#       fetch(
#         :nvm_prefix, -> {
#           "#{fetch(:tmp_dir)}/#{fetch(:application)}/nvm-exec.sh"
#         }
#       )
#     end

#     after 'nvm:validate', 'nvm:webpacker:validate'
#     before 'deploy:assets:precompile', 'nvm:webpacker:wrap'
#     after 'deploy:assets:precompile', 'nvm:webpacker:unwrap'
#   end
# end