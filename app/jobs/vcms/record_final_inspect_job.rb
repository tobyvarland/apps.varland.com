class VCMS::RecordFinalInspectJob < ApplicationJob

  queue_as :default

  def perform(username, shop_order)

    uri = URI.parse("http://vcmsapi.varland.com/record_final_inspection")
    response = Net::HTTP.post_form(uri, username: username, shop_order: shop_order)

  end

end