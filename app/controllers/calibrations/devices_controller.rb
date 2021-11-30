class Calibrations::DevicesController < ApplicationController

  before_action :set_device, only: %i[ show edit update destroy ]

  def index
    @devices = Calibrations::Device.all
  end

  def show
  end

  def new
    @device = Calibrations::Device.new
  end

  def edit
  end

  def create
    @device = Calibrations::Device.new(device_params)
    if @device.save
      redirect_to @device, notice: "Device was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @device.update(device_params)
      redirect_to @device, notice: "Device was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @device.discard
    redirect_to calibrations_devices_url, notice: "Device was successfully destroyed."
  end

  private

    def set_device
      @device = Calibrations::Device.find(params[:id])
    end

    def device_params
      params.require(:calibrations_device).permit(:name,
                                                  :location,
                                                  :in_service_on,
                                                  :retired_on)
    end

end