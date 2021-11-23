class Groov::LogsChannel < ApplicationCable::Channel

  def subscribed
    stream_from "groov_logs_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end