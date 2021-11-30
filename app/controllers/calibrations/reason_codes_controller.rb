class Calibrations::ReasonCodesController < ApplicationController

  before_action :set_reason_code, only: %i[ show edit update destroy ]

  def index
    @reason_codes = Calibrations::ReasonCode.all
  end

  def show
  end

  def new
    @reason_code = Calibrations::ReasonCode.new
  end

  def edit
  end

  def create
    @reason_code = Calibrations::ReasonCode.new(reason_code_params)
    if @reason_code.save
      redirect_to calibrations_reason_codes_url, notice: "Reason code was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @reason_code.update(reason_code_params)
      redirect_to calibrations_reason_codes_url, notice: "Reason code was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reason_code.discard
    redirect_to calibrations_reason_codes_url, notice: "Reason code was successfully destroyed."
  end

  private

    def set_reason_code
      @reason_code = Calibrations::ReasonCode.find(params[:id])
    end

    def reason_code_params
      params.require(:calibrations_reason_code).permit(:name,
                                                       :require_comment)
    end

end