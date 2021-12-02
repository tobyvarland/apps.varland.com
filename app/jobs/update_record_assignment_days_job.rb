class UpdateRecordAssignmentDaysJob < ApplicationJob

  queue_as :default

  def perform
    Records::Assignment.all.each do |obj|
      obj.ensure_due_date_is_workday
      obj.update_days_until_due
      obj.save
    end
  end

end