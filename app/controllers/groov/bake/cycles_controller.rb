class Groov::Bake::CyclesController < ApplicationController
  before_action :set_groov_bake_cycle, only: %i[ show edit update destroy ]

  # GET /groov/bake/cycles or /groov/bake/cycles.json
  def index
    @groov_bake_cycles = Groov::Bake::Cycle.all
  end

  # GET /groov/bake/cycles/1 or /groov/bake/cycles/1.json
  def show
    respond_to do |format|
      format.html {
      }
      format.pdf {
        pdf = Groov::Bake::FinalBakesheetPdf.new(@groov_bake_cycle)
        send_data(pdf.render,
                  filename: "FinalBakesheet.pdf",
                  type: "application/pdf",
                  disposition: "inline")
      }
    end
  end

  # GET /groov/bake/cycles/new
  def new
    @groov_bake_cycle = Groov::Bake::Cycle.new
  end

  # GET /groov/bake/cycles/1/edit
  def edit
  end

  # POST /groov/bake/cycles or /groov/bake/cycles.json
  def create
    @groov_bake_cycle = Groov::Bake::Cycle.new(groov_bake_cycle_params)

    respond_to do |format|
      if @groov_bake_cycle.save
        format.html { redirect_to @groov_bake_cycle, notice: "Cycle was successfully created." }
        format.json { render :show, status: :created, location: @groov_bake_cycle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @groov_bake_cycle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groov/bake/cycles/1 or /groov/bake/cycles/1.json
  def update
    respond_to do |format|
      if @groov_bake_cycle.update(groov_bake_cycle_params)
        format.html { redirect_to @groov_bake_cycle, notice: "Cycle was successfully updated." }
        format.json { render :show, status: :ok, location: @groov_bake_cycle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @groov_bake_cycle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groov/bake/cycles/1 or /groov/bake/cycles/1.json
  def destroy
    @groov_bake_cycle.destroy
    respond_to do |format|
      format.html { redirect_to groov_bake_cycles_url, notice: "Cycle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_groov_bake_cycle
      @groov_bake_cycle = Groov::Bake::Cycle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def groov_bake_cycle_params
      params.require(:groov_bake_cycle).permit(:oven_type, :oven, :side, :cycle_started_at, :loading_finished_at, :purge_ended_at, :soak_started_at, :soak_ended_at, :gas_off_at, :cycle_ended_at, :bake_profile, :setpoint, :minimum, :maximum, :soak_length, :bakestand_number, :rod_cart_number, :discarded_at)
    end
end
