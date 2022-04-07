class Groov::Bake::PlatedLoadsController < ApplicationController
  before_action :set_groov_bake_plated_load, only: %i[ show edit update destroy ]

  # GET /groov/bake/plated_loads or /groov/bake/plated_loads.json
  def index
    @groov_bake_plated_loads = Groov::Bake::PlatedLoad.all
  end

  # GET /groov/bake/plated_loads/1 or /groov/bake/plated_loads/1.json
  def show
  end

  # GET /groov/bake/plated_loads/new
  def new
    @groov_bake_plated_load = Groov::Bake::PlatedLoad.new
  end

  # GET /groov/bake/plated_loads/1/edit
  def edit
  end

  # POST /groov/bake/plated_loads or /groov/bake/plated_loads.json
  def create
    @groov_bake_plated_load = Groov::Bake::PlatedLoad.new(groov_bake_plated_load_params)

    respond_to do |format|
      if @groov_bake_plated_load.save
        format.html { redirect_to @groov_bake_plated_load, notice: "Plated load was successfully created." }
        format.json { render :show, status: :created, location: @groov_bake_plated_load }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @groov_bake_plated_load.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groov/bake/plated_loads/1 or /groov/bake/plated_loads/1.json
  def update
    respond_to do |format|
      if @groov_bake_plated_load.update(groov_bake_plated_load_params)
        format.html { redirect_to @groov_bake_plated_load, notice: "Plated load was successfully updated." }
        format.json { render :show, status: :ok, location: @groov_bake_plated_load }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @groov_bake_plated_load.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groov/bake/plated_loads/1 or /groov/bake/plated_loads/1.json
  def destroy
    @groov_bake_plated_load.destroy
    respond_to do |format|
      format.html { redirect_to groov_bake_plated_loads_url, notice: "Plated load was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_groov_bake_plated_load
      @groov_bake_plated_load = Groov::Bake::PlatedLoad.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def groov_bake_plated_load_params
      params.require(:groov_bake_plated_load).permit(:load_id, :as400_shop_order_id, :number, :department, :out_of_plating_at, :bake_within)
    end
end
