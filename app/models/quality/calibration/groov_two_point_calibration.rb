class Quality::Calibration::GroovTwoPointCalibration < Quality::Calibration::Result

  # Validations.
  validates :two_point_low_value,
            :two_point_low_reading,
            :two_point_high_value,
            :two_point_high_reading,
            :two_point_offset,
            :two_point_gain,
            presence: true
  validates :two_point_low_value,
            :two_point_low_reading,
            :two_point_high_value,
            :two_point_high_reading,
            :two_point_gain,
            numericality: { greater_than: 0 }
  validates :two_point_offset,
            numericality: true

  # Callbacks.
  after_initialize  :load_category_defaults, if: :new_record?

  # Instance methods.

  # Description of individual calibration. Must be overridden in child class.
  def description
    return "Performed Groov two point calibration. Tested at #{self.two_point_low_value} & #{self.two_point_high_value}. Actual readings: #{self.two_point_low_reading} & #{self.two_point_high_reading}. Calculated offset: <code>#{self.two_point_offset}</code>. Calculated gain: <code>#{self.two_point_gain}</code>."
  end

  # Loads two point values from device category.
  def load_category_defaults
    return if self.device.blank?
    self.two_point_low_value = self.device.category.two_point_low_value
    self.two_point_high_value = self.device.category.two_point_high_value
  end

end