class VCMS::ShippingController < ApplicationController

  skip_before_action  :authenticate_user!
  before_action       :prevent_cache

  def promise_list
    @auto_refresh = 599
    @orders = load_json "http://vcmsapi.varland.com/promise_list"
    unless @orders.blank?
      @dates = @orders.map{|o| {value: o[:promise_date], parsed: Date.strptime(o[:promise_date].to_s, "%Y-%m-%d"), orders: @orders.reject{|x| x[:promise_date] != o[:promise_date]}}}.uniq
    end
  end

  def labeling_instructions
    @instructions = nil
    if params[:shop_order]
      @instructions = load_json "http://vcmsapi.varland.com/labeling_instructions?shop_order=#{params[:shop_order].squish}"
    end
  end

end