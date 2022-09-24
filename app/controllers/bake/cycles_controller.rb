class Bake::CyclesController < ApplicationController

  before_action :set_bake_cycle,
                only: %i[ show edit update destroy ]

  def index
    @bake_cycles = Bake::Cycle.all
    @new_large_oven_cycle = Bake::LargeOvenCycle.new
    @new_large_oven_cycle.stands.build(type: "Bake::LargeStand")
    @new_small_oven_cycle = Bake::SmallOvenCycle.new
    @new_small_oven_cycle.stands.build(type: "Bake::SmallStand")
    @new_grieve_cycle = Bake::GrieveCycle.new
    @new_grieve_cycle.stands.build(type: "Bake::LargeStand")
    @new_grieve_cycle.stands.build(type: "Bake::RodCart")
    @new_jpw_cycle = Bake::JpwCycle.new
    @new_jpw_cycle.stands.build(type: "Bake::LargeStand")
    @new_jpw_cycle.stands.build(type: "Bake::RodCart")
  end

  def show
  end

  def new
    @bake_cycle = Bake::Cycle.new
    @bake_cycle.stands.build
  end

  def edit
  end

  def create
    @bake_cycle = Bake::Cycle.new(bake_cycle_params)
    respond_to do |format|
      if @bake_cycle.save
        format.html { redirect_to bake_cycle_path(@bake_cycle), notice: "Cycle was successfully created." }
        format.json { render :show, status: :created, location: @bake_cycle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bake_cycle.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def destroy
    @bake_cycle.destroy
    respond_to do |format|
      format.html { redirect_to bake_cycles_url, notice: "Cycle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_bake_cycle
      @bake_cycle = Bake::Cycle.find(params[:id])
    end

    def bake_cycle_params
      if params[:bake_large_oven_cycle].present?
        params.require(:bake_large_oven_cycle).permit(:type, stands_attributes: [:type, :name])
      elsif params[:bake_small_oven_cycle].present?
        params.require(:bake_small_oven_cycle).permit(:type, stands_attributes: [:type, :name])
      elsif params[:bake_grieve_cycle].present?
        params.require(:bake_grieve_cycle).permit(:type, stands_attributes: [:type, :name])
      elsif params[:bake_jpw_cycle].present?
        params.require(:bake_jpw_cycle).permit(:type, stands_attributes: [:type, :name])
      else
        params.require(:bake_cycle).permit(:type, :oven, :side, :is_locked, :cycle_started_at, :loadings_finished_at, :purge_finished_at, :soak_started_at, :soak_ended_at, :gas_off_at, :cooling_finished_at, :cycle_ended_at, :psi_consumed, :used_cooling_profile, :user_id)
      end
    end

end