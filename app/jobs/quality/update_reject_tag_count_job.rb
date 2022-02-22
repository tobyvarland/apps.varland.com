class Quality::UpdateRejectTagCountJob < ApplicationJob

  queue_as :default

  def perform(shop_order)

    # Count reject tags for shop order.
    tags = Quality::RejectTag.with_shop_order(shop_order)

    # POST tag count to System i.
    uri = URI.parse("http://vcmsapi.varland.com/set_reject_tag_count")
    response = Net::HTTP.post_form(uri, shop_order: shop_order, reject_tags: tags.length)

  end

end