class Groov::Baking::CyclesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create, :update]
  skip_before_action :authenticate_user!, except: [:destroy]
  before_action :set_groov_baking_cycle, only: %i[ show edit update destroy ]

  def index
    begin
      @pagy, @groov_baking_cycles = pagy(Groov::Baking::Cycle.order(cycle_ended_at: :desc), items: 100)
    rescue
      @pagy, @groov_baking_cycles = pagy(Groov::Baking::Cycle.order(cycle_ended_at: :desc), items: 100, page: 1)
    end
  end

  def show
    respond_to do |format|
      format.html {
      }
      format.pdf {
        pdf = Groov::Baking::IAOFinalBakesheetPdf.new(@groov_baking_cycle)
        send_data(pdf.render,
                  filename: "FinalBakesheet.pdf",
                  type: "application/pdf",
                  disposition: "inline")
      }
    end
  end

  def new
    @groov_baking_cycle = Groov::Baking::Cycle.new
  end

  def edit
  end

  def create
    @groov_baking_cycle = Groov::Baking::Cycle.new(groov_baking_cycle_params)
    respond_to do |format|
      if @groov_baking_cycle.save
        format.html { redirect_to @groov_baking_cycle, notice: "Cycle was successfully created." }
        format.json { render :show, status: :created, location: @groov_baking_cycle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @groov_baking_cycle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @groov_baking_cycle.update(groov_baking_cycle_params)
        format.html { redirect_to @groov_baking_cycle, notice: "Cycle was successfully updated." }
        format.json { render :show, status: :ok, location: @groov_baking_cycle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @groov_baking_cycle.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @groov_baking_cycle.destroy
    respond_to do |format|
      format.html { redirect_to groov_baking_cycles_url, notice: "Cycle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_groov_baking_cycle
      @groov_baking_cycle = Groov::Baking::Cycle.find(params[:id])
    end

    def groov_baking_cycle_params
      params.require(:groov_baking_cycle).permit(:bake_type,
                                                 :oven,
                                                 :cycle_started_at,
                                                 :purge_ended_at,
                                                 :soak_started_at,
                                                 :soak_ended_at,
                                                 :gas_off_at,
                                                 :cycle_ended_at,
                                                 :setpoint,
                                                 :minimum,
                                                 :maximum,
                                                 :soak_length,
                                                 :profile_name)
    end

end