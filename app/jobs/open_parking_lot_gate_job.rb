class OpenParkingLotGateJob < ApplicationJob

  queue_as :default

  def perform(*args)
    SetGroovDigitalOutputStatusJob.perform_now  module: 0,
                                                channel: 4,
                                                state: true,
                                                groov: :riomaint
    SetGroovDigitalOutputStatusJob.set(wait: 1.seconds).perform_later module: 0,
                                                                      channel: 4,
                                                                      state: false,
                                                                      groov: :riomaint
  end

end