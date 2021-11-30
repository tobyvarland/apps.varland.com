class UpdateCalibrationAssignmentDaysJob < ApplicationJob

  queue_as :default

  def perform
    Calibrations::Assignment.all.each do |obj|
      obj.update_days_until_due
      obj.save
    end
  end

end