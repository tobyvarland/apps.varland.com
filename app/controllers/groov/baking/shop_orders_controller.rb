class Groov::Baking::ShopOrdersController < ApplicationController
  before_action :set_groov_baking_shop_order, only: %i[ show edit update destroy ]

  # GET /groov/baking/shop_orders or /groov/baking/shop_orders.json
  def index
    @groov_baking_shop_orders = Groov::Baking::ShopOrder.all
  end

  # GET /groov/baking/shop_orders/1 or /groov/baking/shop_orders/1.json
  def show
  end

  # GET /groov/baking/shop_orders/new
  def new
    @groov_baking_shop_order = Groov::Baking::ShopOrder.new
  end

  # GET /groov/baking/shop_orders/1/edit
  def edit
  end

  # POST /groov/baking/shop_orders or /groov/baking/shop_orders.json
  def create
    @groov_baking_shop_order = Groov::Baking::ShopOrder.new(groov_baking_shop_order_params)

    respond_to do |format|
      if @groov_baking_shop_order.save
        format.html { redirect_to @groov_baking_shop_order, notice: "Shop order was successfully created." }
        format.json { render :show, status: :created, location: @groov_baking_shop_order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @groov_baking_shop_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groov/baking/shop_orders/1 or /groov/baking/shop_orders/1.json
  def update
    respond_to do |format|
      if @groov_baking_shop_order.update(groov_baking_shop_order_params)
        format.html { redirect_to @groov_baking_shop_order, notice: "Shop order was successfully updated." }
        format.json { render :show, status: :ok, location: @groov_baking_shop_order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @groov_baking_shop_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groov/baking/shop_orders/1 or /groov/baking/shop_orders/1.json
  def destroy
    @groov_baking_shop_order.destroy
    respond_to do |format|
      format.html { redirect_to groov_baking_shop_orders_url, notice: "Shop order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_groov_baking_shop_order
      @groov_baking_shop_order = Groov::Baking::ShopOrder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def groov_baking_shop_order_params
      params.require(:groov_baking_shop_order).permit(:cycle_id, :shop_order_id)
    end
end
