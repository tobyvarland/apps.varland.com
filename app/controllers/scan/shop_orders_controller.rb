class Scan::ShopOrdersController < ApplicationController
  before_action :set_scan_shop_order, only: %i[ show edit update destroy ]

  # GET /scan/shop_orders or /scan/shop_orders.json
  def index
    @scan_shop_orders = Scan::ShopOrder.all
  end

  # GET /scan/shop_orders/1 or /scan/shop_orders/1.json
  def show
  end

  # GET /scan/shop_orders/new
  def new
    @scan_shop_order = Scan::ShopOrder.new
  end

  # GET /scan/shop_orders/1/edit
  def edit
  end

  # POST /scan/shop_orders or /scan/shop_orders.json
  def create
    @scan_shop_order = Scan::ShopOrder.new(scan_shop_order_params)

    respond_to do |format|
      if @scan_shop_order.save
        format.html { redirect_to @scan_shop_order, notice: "Shop order was successfully created." }
        format.json { render :show, status: :created, location: @scan_shop_order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @scan_shop_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scan/shop_orders/1 or /scan/shop_orders/1.json
  def update
    respond_to do |format|
      if @scan_shop_order.update(scan_shop_order_params)
        format.html { redirect_to @scan_shop_order, notice: "Shop order was successfully updated." }
        format.json { render :show, status: :ok, location: @scan_shop_order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @scan_shop_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scan/shop_orders/1 or /scan/shop_orders/1.json
  def destroy
    @scan_shop_order.destroy
    respond_to do |format|
      format.html { redirect_to scan_shop_orders_url, notice: "Shop order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scan_shop_order
      @scan_shop_order = Scan::ShopOrder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def scan_shop_order_params
      params.require(:scan_shop_order).permit(:shop_order_id, :document_id)
    end
end
