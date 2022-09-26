class Bake::LoadsController < ApplicationController

  before_action :set_bake_load,
                only: %i[ show edit update destroy ]

  def index
    @bake_loads = Bake::Load.all
  end

  def create
    @bake_load = Bake::Load.new(bake_load_params)
    if @bake_load.save
      redirect_to bake_cycle_path(@bake_load.cycle)
    else
      redirect_to bake_cycle_path(@bake_load.cycle), alert: "Error adding load to cycle. Contact IT for help."
    end
  end

  def destroy
    @bake_load.destroy
    redirect_to bake_cycle_path(@bake_load.cycle)
  end

  private

    def set_bake_load
      @bake_load = Bake::Load.find(params[:id])
    end

    def bake_load_params
      params.require(:bake_load).permit(:shop_order_id, :number)
    end

end