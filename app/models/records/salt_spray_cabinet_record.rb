class Records::SaltSprayCabinetRecord < Records::Result

  # Validations.
	validates	:temperature,
            :ph,
            :salt_added,
            :distilled_water_added,
            :weight,
            numericality: true,
            allow_blank: true

  # Callbacks.
  before_save :calculate_fields

  # Instance methods.

  # Calculates values before save.
  def calculate_fields
    self.is_valid = self.ph.between?(6.5, 7.2) unless self.ph.blank?
  end

end