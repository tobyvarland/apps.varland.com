class Bake::StandardProceduresController < ApplicationController

  before_action :set_bake_standard_procedure,
                only: %i[ show edit update destroy ]

  def index
    @bake_standard_procedures = Bake::StandardProcedure.order(:name)
  end

  def new
    @bake_standard_procedure = Bake::StandardProcedure.new
  end

  def edit
  end

  def create
    @bake_standard_procedure = Bake::StandardProcedure.new(bake_standard_procedure_params)
    respond_to do |format|
      if @bake_standard_procedure.save
        format.html { redirect_to bake_standard_procedures_url, notice: "Standard procedure was successfully created." }
        format.json { render :show, status: :created, location: @bake_standard_procedure }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bake_standard_procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bake_standard_procedure.update(bake_standard_procedure_params)
        format.html { redirect_to bake_standard_procedures_url, notice: "Standard procedure was successfully updated." }
        format.json { render :show, status: :ok, location: @bake_standard_procedure }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bake_standard_procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bake_standard_procedure.destroy
    respond_to do |format|
      format.html { redirect_to bake_standard_procedures_url, notice: "Standard procedure was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_bake_standard_procedure
      @bake_standard_procedure = Bake::StandardProcedure.find(params[:id])
    end

    def bake_standard_procedure_params
      params.require(:bake_standard_procedure).permit(:name, :process_codes, :setpoint, :minimum, :maximum, :soak_hours, :within_hours, :profile_name)
    end
end
