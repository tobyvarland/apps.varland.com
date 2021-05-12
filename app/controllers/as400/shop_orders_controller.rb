class AS400::ShopOrdersController < ApplicationController

  before_action :set_shop_order, only: %i[ refresh_trico_labels print_trico_labels ]

  def refresh_trico_labels
    @shop_order.refresh_trico_labels
    redirect_to trico_labels_url
  end

  def print_trico_labels
    Shipping::PrintTricoLabelsJob.perform_later @shop_order
    @shop_order.printed_trico_labels = true
    @shop_order.save
    redirect_to trico_labels_url
  end

  private

    def set_shop_order
      @shop_order = AS400::ShopOrder.friendly.find(params[:id])
    end

end