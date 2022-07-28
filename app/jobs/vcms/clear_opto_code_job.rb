class VCMS::ClearOptoCodeJob < ApplicationJob

  queue_as :default

  def perform(cleared_by, shop_order, load, code, timestamp, ip)

    # POST to System i.
    uri = URI.parse("http://json400.varland.com/clear_opto_code")
    response = Net::HTTP.post_form(uri, shop_order: shop_order, load: load, code: code, timestamp: timestamp, cleared_by: cleared_by, ip: ip)

  end

end