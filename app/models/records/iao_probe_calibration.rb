class Records::IAOProbeCalibration < Records::Result

  # Validations.
	validates	:expected_low,
            :actual_low,
            :expected_high,
            :actual_high,
            presence: true,
            numericality: true

  # Callbacks.
  before_save :calculate_fields

  # Instance methods.

  # Calculates values before save.
  def calculate_fields
    offset_low = self.expected_low - self.actual_low
    offset_high = self.expected_high - self.actual_high
    min_offset = [offset_low, offset_high].min
    max_offset = [offset_low, offset_high].max
    self.offset = min_offset + ((max_offset - min_offset) / 2)
  end

  # Returns summary details for individual record.
  def details
    return <<-DETAILS
    IAO probe calibration.
    Low (expected/actual): <code class="fw-700">#{self.expected_low}</code> / <code class="fw-700">#{self.actual_low}</code>.
    High (expected/actual): <code class="fw-700">#{self.expected_high}</code> / <code class="fw-700">#{self.actual_high}</code>.
    Calculated offset: <code class="fw-700">#{ApplicationController.helpers.number_with_precision self.offset, precision: 2}</code>.
    DETAILS
  end

end