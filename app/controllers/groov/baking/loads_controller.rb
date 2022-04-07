class Groov::Baking::LoadsController < ApplicationController
  before_action :set_groov_baking_load, only: %i[ show edit update destroy ]

  # GET /groov/baking/loads or /groov/baking/loads.json
  def index
    @groov_baking_loads = Groov::Baking::Load.all
  end

  # GET /groov/baking/loads/1 or /groov/baking/loads/1.json
  def show
  end

  # GET /groov/baking/loads/new
  def new
    @groov_baking_load = Groov::Baking::Load.new
  end

  # GET /groov/baking/loads/1/edit
  def edit
  end

  # POST /groov/baking/loads or /groov/baking/loads.json
  def create
    @groov_baking_load = Groov::Baking::Load.new(groov_baking_load_params)

    respond_to do |format|
      if @groov_baking_load.save
        format.html { redirect_to @groov_baking_load, notice: "Load was successfully created." }
        format.json { render :show, status: :created, location: @groov_baking_load }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @groov_baking_load.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groov/baking/loads/1 or /groov/baking/loads/1.json
  def update
    respond_to do |format|
      if @groov_baking_load.update(groov_baking_load_params)
        format.html { redirect_to @groov_baking_load, notice: "Load was successfully updated." }
        format.json { render :show, status: :ok, location: @groov_baking_load }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @groov_baking_load.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groov/baking/loads/1 or /groov/baking/loads/1.json
  def destroy
    @groov_baking_load.destroy
    respond_to do |format|
      format.html { redirect_to groov_baking_loads_url, notice: "Load was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_groov_baking_load
      @groov_baking_load = Groov::Baking::Load.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def groov_baking_load_params
      params.require(:groov_baking_load).permit(:shop_order_id, :number, :is_rework)
    end
end
