class Quality::Calibration::HardnessTesterDailyVerificationsController < Quality::Calibration::ResultsController

  def create
    @result = Quality::Calibration::HardnessTesterDailyVerification.new(result_params)
    if @result.save
      redirect_to @result.device, notice: "Result was successfully created."
    else
			@device = @result.device
      render "quality/calibration/devices/show", status: :unprocessable_entity
    end
  end

  private

    def result_params
      params.require(:quality_calibration_hardness_tester_daily_verification).permit(:device_id,
                                                                                     :user_id,
                                                                                     :reason_code_id,
                                                                                     :calibrated_on,
                                                                                     :reading_1,
                                                                                     :reading_2,
                                                                                     :test_block)
    end

end