class Quality::Calibration::ReasonCodesController < ApplicationController

  before_action :set_reason_code, only: %i[ edit update destroy ]

  def index
    authorize(Quality::Calibration::ReasonCode)
    @reason_codes = Quality::Calibration::ReasonCode.all
  end

  def new
    authorize(Quality::Calibration::ReasonCode)
    @reason_code = Quality::Calibration::ReasonCode.new
  end

  def edit
    authorize(@reason_code)
  end

  def create
    @reason_code = Quality::Calibration::ReasonCode.new(reason_code_params)
    authorize(@reason_code)
    if @reason_code.save
      redirect_to quality_calibration_reason_codes_url, notice: "Reason code was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize(@reason_code)
    if @reason_code.update(reason_code_params)
      redirect_to quality_calibration_reason_codes_url, notice: "Reason code was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@reason_code)
    @reason_code.discard
    redirect_to quality_calibration_reason_codes_url, notice: "Reason code was successfully destroyed."
  end

  private

    def set_reason_code
      @reason_code = Quality::Calibration::ReasonCode.find(params[:id])
    end

    def reason_code_params
      params.require(:quality_calibration_reason_code).permit(:name, :discarded_at)
    end

end