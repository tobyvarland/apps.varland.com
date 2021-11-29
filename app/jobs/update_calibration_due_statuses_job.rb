class UpdateCalibrationDueStatusesJob < ApplicationJob

  queue_as :default

  def perform
    Quality::Calibration::Device.all.each do |device|
      device.set_calibration_due_status
    end

  end

end
