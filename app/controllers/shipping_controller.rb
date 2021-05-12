class ShippingController < ApplicationController

  def trico_labels
    @orders = AS400::ShopOrder.trico_labels_not_printed.order(:number).includes(:trico_bins).reject { |order| order.trico_bins.count == 0 }
  end

end