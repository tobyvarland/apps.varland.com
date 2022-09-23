class Bake::CyclesController < ApplicationController
  before_action :set_bake_cycle, only: %i[ show edit update destroy ]

  # GET /bake/cycles or /bake/cycles.json
  def index
    @bake_cycles = Bake::Cycle.all
  end

  # GET /bake/cycles/1 or /bake/cycles/1.json
  def show
  end

  # GET /bake/cycles/new
  def new
    @bake_cycle = Bake::Cycle.new
  end

  # GET /bake/cycles/1/edit
  def edit
  end

  # POST /bake/cycles or /bake/cycles.json
  def create
    @bake_cycle = Bake::Cycle.new(bake_cycle_params)

    respond_to do |format|
      if @bake_cycle.save
        format.html { redirect_to @bake_cycle, notice: "Cycle was successfully created." }
        format.json { render :show, status: :created, location: @bake_cycle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bake_cycle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bake/cycles/1 or /bake/cycles/1.json
  def update
    respond_to do |format|
      if @bake_cycle.update(bake_cycle_params)
        format.html { redirect_to @bake_cycle, notice: "Cycle was successfully updated." }
        format.json { render :show, status: :ok, location: @bake_cycle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bake_cycle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bake/cycles/1 or /bake/cycles/1.json
  def destroy
    @bake_cycle.destroy
    respond_to do |format|
      format.html { redirect_to bake_cycles_url, notice: "Cycle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bake_cycle
      @bake_cycle = Bake::Cycle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bake_cycle_params
      params.require(:bake_cycle).permit(:type, :oven, :side, :is_locked, :cycle_started_at, :loadings_finished_at, :purge_finished_at, :soak_started_at, :soak_ended_at, :gas_off_at, :cooling_finished_at, :cycle_ended_at, :psi_consumed, :used_cooling_profile, :user_id)
    end
end
