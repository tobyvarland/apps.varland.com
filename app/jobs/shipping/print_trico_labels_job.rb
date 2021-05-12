class Shipping::PrintTricoLabelsJob < ApplicationJob

  queue_as :default

  def perform(shop_order)
    
    labels = []
    shop_order.trico_bins.each do |bin|
      labels << {
        shop_order: shop_order.number,
        part_number: shop_order.part,
        po: shop_order.purchase_order[0],
        pieces: bin.total_pieces,
        containers: shop_order.container_count,
        container_type: shop_order.container_type
      }
    end
    uri = URI.parse("http://vcmsapi.varland.com/print_trico_labels")
    Net::HTTP.post_form(uri, labels: ActiveSupport::JSON.encode(labels))

  end

end