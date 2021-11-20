class Quality::Calibration::CalibrationsController < ApplicationController
  before_action :set_calibration, only: %i[ show edit update destroy ]

  def index
    authorize(Quality::Calibration::Calibration)
    @calibrations = Quality::Calibration::Calibration.all
  end

  def new
    authorize(Quality::Calibration::Calibration)
    @calibration = Quality::Calibration::Calibration.new calibrated_on: Date.current
  end

  def edit
    authorize(@calibration)
  end

  def create
    @calibration = Quality::Calibration::Calibration.new(calibration_params)
    authorize(@calibration)  
    if @calibration.save
      redirect_to quality_calibration_calibrations_url, notice: "Calibration was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end  
  end

  def update
    authorize(@calibration)  
    if @calibration.update(calibration_params)
      redirect_to quality_calibration_calibrations_url, notice: "Calibration was successfully updated."        
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    authorize(@calibration)
    @calibration.discard
    redirect_to quality_calibration_calibrations_url, notice: "Calibration was successfully destroyed."
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calibration
      @calibration = Quality::Calibration::Calibration.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def calibration_params
      params.require(:quality_calibration_calibration).permit(:device_id, :user_id, :reason_code_id, :calibrated_on, :calibration_successful)
    end
end
