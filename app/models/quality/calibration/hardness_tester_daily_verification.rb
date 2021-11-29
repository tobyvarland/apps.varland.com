class Quality::Calibration::HardnessTesterDailyVerification < Quality::Calibration::Result

  # Validations.
  validates :reading_1,
            :reading_2,
            :test_block,
            :maximum_error,
            :maximum_repeatability,
            presence: true,
            numericality: { greater_than: 0 }
  validates :rockwell_scale,
            :test_block_serial,
            presence: true

  # Callbacks.
  after_initialize  :load_category_defaults, if: :new_record?

  # Instance methods.

  # Returns average of readings.
  def average
    return ((self.reading_1 + self.reading_2) / 2).round(2)
  end

  # Returns error in readings.
  def error
    return (self.average - self.test_block).round(2)
  end

  # Returns repeatability of readings.
  def repeatability
    return (self.reading_1 - self.reading_2).abs.round(2)
  end

  # Description of individual calibration. Must be overridden in child class.
  def description
    parts = ["Hardness tester daily verification."]
    parts << "Error:"
    parts << ApplicationController.helpers.fa("#{self.error.abs <= self.maximum_error ? "check" : "times"}-circle", text_class: "text-#{self.error.abs <= self.maximum_error ? "green" : "red"}-500")
    parts << "<code>#{self.error}</code>."
    parts << "Repeatability:"
    parts << ApplicationController.helpers.fa("#{self.repeatability.abs <= self.maximum_repeatability ? "check" : "times"}-circle", text_class: "text-#{self.repeatability.abs <= self.maximum_repeatability ? "green" : "red"}-500")
    parts << "<code>#{self.repeatability}</code>."
    return parts.join ' '
  end

  # Loads two point values from device category.
  def load_category_defaults
    return if self.device.blank?
    self.test_block = self.device.category.test_block_hardness
    self.rockwell_scale = self.device.category.rockwell_scale
    self.test_block_serial = self.device.category.test_block_serial
    self.maximum_error = self.device.category.maximum_error
    self.maximum_repeatability = self.device.category.maximum_repeatability
  end

end