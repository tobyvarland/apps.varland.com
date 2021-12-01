class Records::ReasonCodesController < ApplicationController

  before_action :set_reason_code, only: %i[ show edit update destroy ]

  def index
    authorize :records, :admin?
    @reason_codes = Records::ReasonCode.all
  end

  def show
    authorize :records, :admin?
  end

  def new
    authorize :records, :admin?
    @reason_code = Records::ReasonCode.new
  end

  def edit
    authorize :records, :admin?
  end

  def create
    authorize :records, :admin?
    @reason_code = Records::ReasonCode.new(reason_code_params)
    if @reason_code.save
      redirect_to records_reason_codes_url, notice: "Reason code was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize :records, :admin?
    if @reason_code.update(reason_code_params)
      redirect_to records_reason_codes_url, notice: "Reason code was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize :records, :admin?
    @reason_code.discard
    redirect_to records_reason_codes_url, notice: "Reason code was successfully destroyed."
  end

  private

    def set_reason_code
      @reason_code = Records::ReasonCode.find(params[:id])
    end

    def reason_code_params
      params.require(:records_reason_code).permit(:name)
    end

end