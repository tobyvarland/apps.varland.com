class Records::GroovTwoPointCalibration < Records::Result

  # Validations.
	validates	:expected_low,
            :actual_low,
            :expected_high,
            :actual_high,
            :offset,
            :gain,
            presence: true,
            numericality: true

  # Instance methods.

  # Returns summary details for individual record.
  def details
    return <<-DETAILS
    Groov two point calibration.
    Low (expected/actual): <code class="fw-700">#{self.expected_low}</code> / <code class="fw-700">#{self.actual_low}</code>.
    High (expected/actual): <code class="fw-700">#{self.expected_high}</code> / <code class="fw-700">#{self.actual_high}</code>.
    Calculated offset: <code class="fw-700">#{self.offset}</code>.
    Calculated gain: <code class="fw-700">#{self.gain}</code>.
    DETAILS
  end

end