# frozen_string_literal: true

def add_groov_log_descriptions
  count = 0
  Groov::Log.find_each do |log|
    next unless log.description.blank?
    log.save
    count += 1
    puts "🔴 #{count}"
  end
end

namespace :varland do
  desc 'Update existing Groov::Log records with description'
  task describe_groov_logs: :environment do
    add_groov_log_descriptions
  end
end