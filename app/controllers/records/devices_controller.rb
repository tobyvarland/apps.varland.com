class Records::DevicesController < ApplicationController

  before_action :set_device, only: %i[ show edit update destroy ]

  def index
    @devices = Records::Device.by_name
  end

  def show
  end

  def new
    @device = Records::Device.new
  end

  def edit
  end

  def create
    @device = Records::Device.new(device_params)
    if @device.save
      redirect_to records_devices_url, notice: "Device '#{@device.name}' was successfully created.".html_safe
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
    redirect_to records_devices_url, notice: "Device was successfully destroyed."
  end

  private

    def set_device
      @device = Records::Device.find(params[:id])
    end

    def device_params
      params.require(:records_device).permit(:name,
                                                  :location,
                                                  :in_service_on,
                                                  :retired_on,
                                                  assignments_attributes: [:id, :record_type_id, :_destroy])
    end

end