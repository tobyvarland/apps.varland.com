class Calibrations::HardnessTesterDailyVerification < Calibrations::Result

  # Validations.
	validates	:rockwell_scale,
            :test_block_serial,
            presence: true
	validates	:test_block_hardness,
            :max_error,
            :max_repeatability,
            :reading_1,
            :reading_2,
            presence: true,
            numericality: true

  # Instance methods.

  # Returns average of readings.
  def average
    return [self.reading_1, self.reading_2].sum(0.0) / 2;
  end

  # Returns error of average of readings.
  def error
    return self.average - self.test_block_hardness
  end

  # Returns repeatability of readings.
  def repeatability
    return (self.reading_1 - self.reading_2).abs
  end

end