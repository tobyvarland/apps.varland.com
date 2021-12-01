class Records::DevicesController < ApplicationController

  before_action :set_device, only: %i[ show edit update destroy ]

  def index
    authorize :records, :view?
    @devices = Records::Device.by_name
  end

  def show
    authorize :records, :view?
  end

  def new
    authorize :records, :admin?
    @device = Records::Device.new
  end

  def edit
    authorize :records, :admin?
  end

  def create
    authorize :records, :admin?
    @device = Records::Device.new(device_params)
    if @device.save
      redirect_to records_devices_url, notice: "Device '#{@device.name}' was successfully created.".html_safe
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize :records, :admin?
    if @device.update(device_params)
      redirect_to @device, notice: "Device was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize :records, :admin?
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