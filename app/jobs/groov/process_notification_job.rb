class Groov::ProcessNotificationJob < ApplicationJob

  queue_as :default

  def perform(log)
    puts "\n🔴 🟠 🟡 🟢 🔵 🟣 ⚫️ ⚪️ 🟤\n\n"
    puts log.notification_settings
    puts "\n🔴 🟠 🟡 🟢 🔵 🟣 ⚫️ ⚪️ 🟤\n\n"
    if log.notification_settings[:enabled]
      Groov::LogMailer.with(log: log).log_notification.deliver_later
    end
  end

end