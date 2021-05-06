require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module AppsVarlandCom
  class Application < Rails::Application
    
    config.load_defaults 6.1

    config.active_job.queue_adapter = :sidekiq
    config.active_job.default_queue_name = :default
    config.active_storage.queues.analysis = :default

    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.stylesheets false
      generate.jbuilder false
    end
    
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :local

    config.active_storage.content_types_allowed_inline << "video/mp4"
    config.active_storage.content_types_allowed_inline << "text/html"
    config.active_storage.content_types_allowed_inline << "image/svg+xml"
    config.active_storage.content_types_allowed_inline << "text/xml"
    config.active_storage.content_types_allowed_inline << "application/xml"
    config.active_storage.content_types_allowed_inline << "text/plain"
    config.active_storage.content_types_allowed_inline << "application/json"
    config.active_storage.content_types_allowed_inline << "text/markdown"
    config.active_storage.content_types_to_serve_as_binary -= ["text/html", "image/svg+xml", "text/xml", "application/xml"]
    
  end
end