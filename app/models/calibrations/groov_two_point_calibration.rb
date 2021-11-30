class Calibrations::GroovTwoPointCalibration < Calibrations::Result

  # Validations.
	validates	:expected_low,
            :actual_low,
            :expected_high,
            :actual_high,
            :offset,
            :gain,
            presence: true,
            numericality: true

end