class Scan::ShopOrderBroadcastJob < ApplicationJob

  queue_as :default

  def perform(shop_order)
    ActionCable.server.broadcast("scan_shop_orders_channel", so: render_so(shop_order))
  end

  private

    def render_so(shop_order)
      ApplicationController.renderer.render(partial: "scan/shop_orders/shop_order", locals: { so: shop_order })
    end

end