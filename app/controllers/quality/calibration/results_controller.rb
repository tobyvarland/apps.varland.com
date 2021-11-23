class Quality::Calibration::ResultsController < ApplicationController

  def index
    authorize(Quality::Calibration::Result)
    @results = Quality::Calibration::Result.all
  end

  def destroy
    @result = Quality::Calibration::Result.find(params[:id])
    authorize(@result)
    @result.discard
    redirect_back fallback_location: @result.device, notice: "Result was successfully destroyed."
  end

end