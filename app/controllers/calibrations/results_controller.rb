class Calibrations::ResultsController < ApplicationController

  before_action :set_result, only: %i[ show edit update destroy ]

  def index
    @results = Calibrations::Result.all
  end

  def show
  end

  def new
    @result = Calibrations::Result.new
  end

  def edit
  end

  def create
    @result = Calibrations::Result.new(result_params)
    if @result.save
      redirect_to @result, notice: "Result was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @result.update(result_params)
      redirect_to @result, notice: "Result was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @result.discard
    redirect_to calibrations_results_url, notice: "Result was successfully destroyed."
  end

  private

    def set_result
      @result = Calibrations::Result.find(params[:id])
    end

    def result_params
      params.require(:calibrations_result).permit(:type,
                                                  :device_id,
                                                  :calibration_type_id,
                                                  :user_id,
                                                  :reason_code_id,
                                                  :result_on)
    end

end