class OpenHallwayDoorJob < ApplicationJob

  queue_as :default

  def perform(*args)
    SetGroovDigitalOutputStatusJob.perform_now  module: 0,
                                                channel: 6,
                                                state: true,
                                                groov: :riomaint
    SetGroovDigitalOutputStatusJob.set(wait: 5.seconds).perform_later module: 0,
                                                                      channel: 6,
                                                                      state: false,
                                                                      groov: :riomaint
  end

end