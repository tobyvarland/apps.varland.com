class ReclassifyGroovLogsJob < ApplicationJob

  queue_as :default

  def perform
    Groov::GroovLog.all.each do |log|
      type_exists = log.groov_data[:type].constantize rescue false
      if type_exists
        log.type = log.groov_data[:type]
        log.extract_details
        log.save
      end
    end
  end

end