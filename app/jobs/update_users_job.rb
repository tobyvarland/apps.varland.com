class UpdateUsersJob < ApplicationJob

  queue_as :default

  def perform
    User.where(employee_number: 937).each do |user|
      user.update_fields_from_system_i
    end
  end

end