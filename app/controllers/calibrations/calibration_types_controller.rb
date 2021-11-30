class Calibrations::CalibrationTypesController < ApplicationController

  before_action :set_calibration_type, only: %i[ show edit update destroy ]

  def index
    @calibration_types = Calibrations::CalibrationType.all
  end

  def show
  end

  def new
    @calibration_type = Calibrations::CalibrationType.new
  end

  def edit
  end

  def create
    @calibration_type = Calibrations::CalibrationType.new(calibration_type_params)
    if @calibration_type.save
      redirect_to calibrations_calibration_types_url, notice: "Calibration type was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @calibration_type.update(calibration_type_params)
      redirect_to @calibration_type, notice: "Calibration type was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @calibration_type.discard
    redirect_to calibrations_calibration_types_url, notice: "Calibration type was successfully destroyed."
  end

  private

    def set_calibration_type
      @calibration_type = Calibrations::CalibrationType.find(params[:id])
    end

    def calibration_type_params
      params.require(:calibrations_calibration_type).permit(:name,
                                                            :frequency,
                                                            :url,
                                                            :calibration_method,
                                                            :is_internal,
                                                            assignments_attributes: [:id, :device_id, :_destroy])
    end

end