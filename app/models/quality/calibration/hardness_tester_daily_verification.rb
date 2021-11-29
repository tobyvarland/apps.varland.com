class Quality::Calibration::HardnessTesterDailyVerification < Quality::Calibration::Result

  # Validations.
  validates :reading_1,
            :reading_2,
            :test_block,
            presence: true,
            numericality: { greater_than: 0 }

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
    return "Hardness tester daily verification. Error: #{self.error}. Repeatability: #{self.repeatability}."
  end

  # Loads two point values from device category.
  def load_category_defaults
    return if self.device.blank?
    self.test_block = self.device.category.test_block_hardness
  end

end