class Groov::Bake::ShopOrdersController < ApplicationController
  before_action :set_groov_bake_shop_order, only: %i[ show edit update destroy ]

  # GET /groov/bake/shop_orders or /groov/bake/shop_orders.json
  def index
    @groov_bake_shop_orders = Groov::Bake::ShopOrder.all
  end

  # GET /groov/bake/shop_orders/1 or /groov/bake/shop_orders/1.json
  def show
  end

  # GET /groov/bake/shop_orders/new
  def new
    @groov_bake_shop_order = Groov::Bake::ShopOrder.new
  end

  # GET /groov/bake/shop_orders/1/edit
  def edit
  end

  # POST /groov/bake/shop_orders or /groov/bake/shop_orders.json
  def create
    @groov_bake_shop_order = Groov::Bake::ShopOrder.new(groov_bake_shop_order_params)

    respond_to do |format|
      if @groov_bake_shop_order.save
        format.html { redirect_to @groov_bake_shop_order, notice: "Shop order was successfully created." }
        format.json { render :show, status: :created, location: @groov_bake_shop_order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @groov_bake_shop_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groov/bake/shop_orders/1 or /groov/bake/shop_orders/1.json
  def update
    respond_to do |format|
      if @groov_bake_shop_order.update(groov_bake_shop_order_params)
        format.html { redirect_to @groov_bake_shop_order, notice: "Shop order was successfully updated." }
        format.json { render :show, status: :ok, location: @groov_bake_shop_order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @groov_bake_shop_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groov/bake/shop_orders/1 or /groov/bake/shop_orders/1.json
  def destroy
    @groov_bake_shop_order.destroy
    respond_to do |format|
      format.html { redirect_to groov_bake_shop_orders_url, notice: "Shop order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_groov_bake_shop_order
      @groov_bake_shop_order = Groov::Bake::ShopOrder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def groov_bake_shop_order_params
      params.require(:groov_bake_shop_order).permit(:cycle_id, :as400_shop_order_id, :container_type, :operation_letter, :bake_profile, :setpoint, :minimum, :maximum, :soak_length)
    end
end
