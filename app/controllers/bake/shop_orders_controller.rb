class Bake::ShopOrdersController < ApplicationController
  before_action :set_bake_shop_order, only: %i[ show edit update destroy ]

  # GET /bake/shop_orders or /bake/shop_orders.json
  def index
    @bake_shop_orders = Bake::ShopOrder.all
  end

  # GET /bake/shop_orders/1 or /bake/shop_orders/1.json
  def show
  end

  # GET /bake/shop_orders/new
  def new
    @bake_shop_order = Bake::ShopOrder.new
  end

  # GET /bake/shop_orders/1/edit
  def edit
  end

  # POST /bake/shop_orders or /bake/shop_orders.json
  def create
    @bake_shop_order = Bake::ShopOrder.new(bake_shop_order_params)

    respond_to do |format|
      if @bake_shop_order.save
        format.html { redirect_to @bake_shop_order, notice: "Shop order was successfully created." }
        format.json { render :show, status: :created, location: @bake_shop_order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bake_shop_order.errors, status: :unprocessable_entity }
      end
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
