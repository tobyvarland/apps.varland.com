class Quality::Calibration::DevicesController < ApplicationController
  before_action :set_quality_calibration_device, only: %i[ show edit update destroy ]

  def index
    authorize(Quality::Calibration::Device)
    @devices = Quality::Calibration::Device.all
  end

  def new
    authorize(Quality::Calibration::Device)
    @device = Quality::Calibration::Device.new
  end

  def edit
    authorize(@device)
  end

  def create
    @device = Quality::Calibration::Device.new(device_params)
    authorize(@device)  
    if @device.save
      redirect_to quality_calibration_devices_url, notice: "Device was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end  
  end

  def update
    authorize(@device)  
    if @device.update(device_params)
      redirect_to quality_calibration_devices_url, notice: "Device was successfully updated."        
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    authorize(@device)
    @device.discard
    redirect_to quality_calibration_devices_url, notice: "Device was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quality_calibration_device
      @device = Quality::Calibration::Device.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quality_calibration_device_params
      params.require(:quality_calibration_device).permit(:device_id, :name, :location, :in_service_on, :retired_on, :enable_notifications, :discarded_at)
    end
end
