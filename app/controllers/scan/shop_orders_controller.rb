class Scan::ShopOrdersController < ApplicationController

  skip_before_action :authenticate_user!

  before_action :parse_filter_params, only: %i[ index ]

  has_scope :on_or_after
  has_scope :on_or_before
  has_scope :with_search_term
  has_scope :with_shop_order
  has_scope :with_customer
  has_scope :with_process_code
  has_scope :with_part

  def today
    @scan_shop_orders = Scan::ShopOrder.includes(:shop_order).today.order(created_at: :desc)
  end

  def index
    filters_to_cookies
    begin
      @pagy, @scan_shop_orders = pagy(apply_scopes(Scan::ShopOrder.includes(:shop_order).all), items: 100)
    rescue
      @pagy, @scan_shop_orders = pagy(apply_scopes(Scan::ShopOrder.includes(:shop_order).all), items: 100, page: 1)
    end
    @all_scanned_shop_orders = apply_scopes(Scan::ShopOrder.includes(:shop_order).all)
  end

  def show
    @scan_shop_order = Scan::ShopOrder.friendly.find(params[:id])
    send_data(@scan_shop_order.scanned_file.download,
              filename: "#{@scan_shop_order.shop_order_number}.pdf",
              type: "application/pdf",
              disposition: "inline")
  end

end