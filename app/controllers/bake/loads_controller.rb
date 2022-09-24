class Bake::LoadsController < ApplicationController
  before_action :set_bake_load, only: %i[ show edit update destroy ]

  # GET /bake/loads or /bake/loads.json
  def index
    @bake_loads = Bake::Load.all
  end

  # GET /bake/loads/1 or /bake/loads/1.json
  def show
  end

  # GET /bake/loads/new
  def new
    @bake_load = Bake::Load.new
  end

  # GET /bake/loads/1/edit
  def edit
  end

  # POST /bake/loads or /bake/loads.json
  def create
    @bake_load = Bake::Load.new(bake_load_params)

    respond_to do |format|
      if @bake_load.save
        format.html { redirect_to @bake_load, notice: "Load was successfully created." }
        format.json { render :show, status: :created, location: @bake_load }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bake_load.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bake/loads/1 or /bake/loads/1.json
  def update
    respond_to do |format|
      if @bake_load.update(bake_load_params)
        format.html { redirect_to @bake_load, notice: "Load was successfully updated." }
        format.json { render :show, status: :ok, location: @bake_load }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bake_load.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bake/loads/1 or /bake/loads/1.json
  def destroy
    @bake_load.destroy
    respond_to do |format|
      format.html { redirect_to bake_loads_url, notice: "Load was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bake_load
      @bake_load = Bake::Load.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bake_load_params
      params.require(:bake_load).permit(:shop_order_id, :number, :not_loaded, :started_baking_at)
    end
end
