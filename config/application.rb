require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module AppsVarlandCom
  class Application < Rails::Application
    
    config.load_defaults 6.1

    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.stylesheets false
      generate.jbuilder false
    end
    
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :local
    
  end
end