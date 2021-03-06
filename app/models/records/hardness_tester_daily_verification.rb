class Records::HardnessTesterDailyVerification < Records::Result

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

  # Callbacks.
  before_save :calculate_fields

  # Instance methods.

  # Calculates values before save.
  def calculate_fields
    self.reading_average = [self.reading_1, self.reading_2].sum(0.0) / 2
    self.reading_error = self.reading_average - self.test_block_hardness
    self.reading_repeatability = (self.reading_1 - self.reading_2).abs
    self.reading_error_valid = self.reading_error.abs < self.max_error
    self.reading_repeatability_valid = self.reading_repeatability < self.max_repeatability
    self.is_valid = self.reading_error_valid && self.reading_repeatability_valid
  end

end