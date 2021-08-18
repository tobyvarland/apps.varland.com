class Shipping::PrintSmalogLabelsJob < ApplicationJob

  queue_as :default

  def perform(shop_order)
    
    uri = URI.parse("http://vcmsapi.varland.com/print_smalog_labels")
    Net::HTTP.post_form(uri, so: shop_order)

  end

end