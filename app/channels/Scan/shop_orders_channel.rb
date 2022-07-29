class Scan::ShopOrdersChannel < ApplicationCable::Channel

  def subscribed
    stream_from "scan_shop_orders_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end