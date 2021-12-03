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

end