class Groov::Bake::LoadsController < ApplicationController
  before_action :set_groov_bake_load, only: %i[ show edit update destroy ]

  # GET /groov/bake/loads or /groov/bake/loads.json
  def index
    @groov_bake_loads = Groov::Bake::Load.all
  end

  # GET /groov/bake/loads/1 or /groov/bake/loads/1.json
  def show
  end

  # GET /groov/bake/loads/new
  def new
    @groov_bake_load = Groov::Bake::Load.new
  end

  # GET /groov/bake/loads/1/edit
  def edit
  end

  # POST /groov/bake/loads or /groov/bake/loads.json
  def create
    @groov_bake_load = Groov::Bake::Load.new(groov_bake_load_params)

    respond_to do |format|
      if @groov_bake_load.save
        format.html { redirect_to @groov_bake_load, notice: "Load was successfully created." }
        format.json { render :show, status: :created, location: @groov_bake_load }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @groov_bake_load.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groov/bake/loads/1 or /groov/bake/loads/1.json
  def update
    respond_to do |format|
      if @groov_bake_load.update(groov_bake_load_params)
        format.html { redirect_to @groov_bake_load, notice: "Load was successfully updated." }
        format.json { render :show, status: :ok, location: @groov_bake_load }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @groov_bake_load.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groov/bake/loads/1 or /groov/bake/loads/1.json
  def destroy
    @groov_bake_load.destroy
    respond_to do |format|
      format.html { redirect_to groov_bake_loads_url, notice: "Load was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_groov_bake_load
      @groov_bake_load = Groov::Bake::Load.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def groov_bake_load_params
      params.require(:groov_bake_load).permit(:shop_order_id, :number, :is_rework, :is_on_bakestand, :in_oven_at)
    end
end
