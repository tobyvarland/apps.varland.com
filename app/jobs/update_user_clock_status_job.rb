class UpdateUserClockStatusJob < ApplicationJob

  queue_as :default

  def perform(*args)
    api_client = PayrollPartnersApiClient.new
    clocked_in_now = api_client.clocked_in_now
    User.for_pp_time_clock.each do |user|
      user.update(clocked_in_at: clocked_in_now.fetch(user.payroll_account_id, nil))
    end
  end

end