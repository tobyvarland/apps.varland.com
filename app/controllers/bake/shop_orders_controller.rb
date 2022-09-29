class Bake::ShopOrdersController < ApplicationController

  before_action :set_bake_shop_order,
                only: %i[ show edit update destroy ]

  def index
    @bake_shop_orders = Bake::ShopOrder.all
  end

  def show
  end

  def new
    @bake_shop_order = Bake::ShopOrder.new
  end

  def edit
  end

  def create
    @bake_shop_order = Bake::ShopOrder.new(bake_shop_order_params)
    if @bake_shop_order.save
      redirect_to bake_cycle_path(@bake_shop_order.cycle)
    else
      redirect_to bake_cycle_path(@bake_shop_order.cycle), alert: "Error adding shop order. Contact IT for help."
    end
  end

  # PATCH/PUT /bake/shop_orders/1 or /bake/shop_orders/1.json
  def update
    respond_to do |format|
      if @bake_shop_order.update(bake_shop_order_params)
        format.html { redirect_to @bake_shop_order, notice: "Shop order was successfully updated." }
        format.json { render :show, status: :ok, location: @bake_shop_order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bake_shop_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bake/shop_orders/1 or /bake/shop_orders/1.json
  def destroy
    @bake_shop_order.destroy
    respond_to do |format|
      format.html { redirect_to bake_shop_orders_url, notice: "Shop order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bake_shop_order
      @bake_shop_order = Bake::ShopOrder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bake_shop_order_params
      params.require(:bake_shop_order).permit(:cycle_id, :number, :customer, :process, :part, :sub, :operation, :setpoint, :minimum, :maximum, :soak_hours, :within_hours, :profile_name)
    end
end
