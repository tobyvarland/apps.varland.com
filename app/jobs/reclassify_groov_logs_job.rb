class ReclassifyGroovLogsJob < ApplicationJob

  queue_as :default

  def perform
    Groov::GroovLog.all.each do |log|
      if Object.const_defined? @log.groov_data[:type]
        @log.type = @log.groov_data[:type]
        @log.extract_details
        @log.save
      end
    end
  end

end