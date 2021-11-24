class Groov::ProcessNotificationJob < ApplicationJob

  queue_as :default

  def perform(log)
    if log.notification_settings[:enabled]
      Groov::LogMailer.with(log: log).log_notification.deliver
    end
  end

end