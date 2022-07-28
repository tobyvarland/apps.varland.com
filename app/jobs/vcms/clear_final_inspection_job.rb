class VCMS::ClearFinalInspectionJob < ApplicationJob

  queue_as :default

  def perform(shop_order)

    uri = URI.parse("http://json400.varland.com/clear_final_inspection")
    response = Net::HTTP.post_form(uri, shop_order: shop_order)

  end

end