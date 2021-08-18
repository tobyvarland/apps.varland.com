class ShippingController < ApplicationController

  def smalog_labels
    @orders = load_json "http://vcmsapi.varland.com/smalog_orders"
  end

  def trico_labels
    @orders = AS400::ShopOrder.trico_labels_not_printed.order(:number).includes(:trico_bins).reject { |order| order.trico_bins.count == 0 }
  end

end