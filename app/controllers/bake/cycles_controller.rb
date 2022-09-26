class Bake::CyclesController < ApplicationController

  before_action :set_bake_cycle,
                only: %i[ show edit update destroy ]

  def index
    @bake_cycles = Bake::Cycle.not_started
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
    @bake_shop_order = @bake_cycle.shop_orders.build
    @bake_load = Bake::Load.new
  end

  def new
    @bake_cycle = Bake::Cycle.new
    @bake_cycle.stands.build
  end

  def create
    @bake_cycle = Bake::Cycle.new(bake_cycle_params)
    if @bake_cycle.save
      redirect_to bake_cycle_path(@bake_cycle)
    else
      redirect_to bake_cycles_path, alert: "Error creating cycle. Contact IT for help."
    end
  end

  def update
    respond_to do |format|
      if @bake_cycle.update(bake_cycle_params)
        format.html { redirect_to bake_cycle_path(@bake_cycle) }
        format.json { head :ok }
      else
        format.html { redirect_to bake_cycle_path(@bake_cycle), alert: "Error updating cycle. Contact IT for help." }
        format.json { head :unprocessable_entity }
      end
    end
  end

  def destroy
    @bake_cycle.destroy
    redirect_to bake_cycles_url, notice: "Cycle was successfully destroyed."
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
        params.require(:bake_cycle).permit(:oven, :side, :is_locked, :cycle_started_at, :loadings_finished_at, :purge_finished_at, :soak_started_at, :soak_ended_at, :gas_off_at, :cooling_finished_at, :cycle_ended_at, :psi_consumed, :used_cooling_profile, :user_id)
      end
    end

end