require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

require 'capistrano/rails'
require 'capistrano/passenger'
require 'capistrano/nvm'
require 'capistrano/rbenv'

set :nvm_type, :user # or :system, depends on your nvm setup
set :nvm_node, 'v14.21.1'
set :nvm_map_bins, %w{node npm yarn rake}
set :nvm_custom_path, "/Users/varland/.nvm"

set :rbenv_type, :user
set :rbenv_ruby, '2.6.3'