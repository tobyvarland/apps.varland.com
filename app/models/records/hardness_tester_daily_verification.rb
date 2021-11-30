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

  # Instance methods.

  # Returns summary details for individual calibration.
  def details
    return <<-DETAILS
    Test block hardness: <code class="fw-700">#{self.test_block_hardness}</code>.
    Readings: <code class="fw-700">#{self.reading_1}</code> & <code class="fw-700">#{self.reading_2}</code>.
    Error (calculated/max): <code class="fw-700">#{self.error.round(2)}</code> / <code class="fw-700">#{self.max_error}</code>
    <small>#{ApplicationController.helpers.boolean_icon self.error <= self.max_error, true_text: "valid", false_text: "invalid"}</small>.
    Repeatability (calculated/max): <code class="fw-700">#{self.repeatability.round(2)}</code> / <code class="fw-700">#{self.max_repeatability}</code>
    <small>#{ApplicationController.helpers.boolean_icon self.repeatability <= self.max_repeatability, true_text: "valid", false_text: "invalid"}</small>.
    DETAILS
  end

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