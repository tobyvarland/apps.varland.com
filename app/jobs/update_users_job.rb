class UpdateUsersJob < ApplicationJob

  queue_as :default

  def perform
    puts "Need to update users from System i..."
  end

end