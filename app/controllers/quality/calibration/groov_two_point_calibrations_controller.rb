class Quality::Calibration::GroovTwoPointCalibrationsController < Quality::Calibration::ResultsController

  def create
    @result = Quality::Calibration::GroovTwoPointCalibration.new(result_params)
    if @result.save
      redirect_to @result.device, notice: "Result was successfully created."
    else
			@device = @result.device
      render "quality/calibration/devices/show", status: :unprocessable_entity
    end
  end

  private

    def result_params
      params.require(:quality_calibration_groov_two_point_calibration).permit(:device_id,
                                                                              :user_id,
                                                                              :reason_code_id,
                                                                              :calibrated_on,
                                                                              :two_point_low_value,
                                                                              :two_point_low_reading,
                                                                              :two_point_high_value,
                                                                              :two_point_high_reading,
                                                                              :two_point_offset,
                                                                              :two_point_gain)
    end

end