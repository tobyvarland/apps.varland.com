class Groov::LogBroadcastJob < ApplicationJob

  queue_as :default

  def perform(log)
    ActionCable.server.broadcast("groov_logs_channel", log: render_log(log), controller: log.controller_name)
  end

  private

    def render_log(log)
      ApplicationController.renderer.render(partial: "groov/logs/log", locals: { log: log })
    end

end