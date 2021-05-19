class VCMS::LinkPartSpecJob < ApplicationJob

  queue_as :default

  def perform(username, customer, process, part, sub)
    
    uri = URI.parse("http://vcmsapi.varland.com/link_part_spec")
    response = Net::HTTP.post_form(uri, username: username, customer: customer, process: process, part: part, sub: sub)

  end

end