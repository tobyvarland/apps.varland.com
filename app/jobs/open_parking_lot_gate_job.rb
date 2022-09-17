class OpenParkingLotGateJob < ApplicationJob

  queue_as :default

  def perform(*args)
    SetGroovDigitalOutputStatusJob.perform_now  state: true,
                                                groov: :epicplant,
                                                name: "do_GateOpener"
    SetGroovDigitalOutputStatusJob.set(wait: 1.seconds).perform_later state: false,
                                                                      groov: :epicplant,
                                                                      name: "do_GateOpener"
  end

end