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

  # Returns summary details for individual record.
  def details
    details = []
    details << "Salt added: <code class=\"fw-700\">#{self.salt_added}</code>." unless self.salt_added.blank?
    details << "Distilled water added: <code class=\"fw-700\">#{self.distilled_water_added}</code>." unless self.distilled_water_added.blank?
    details << "pH: <code class=\"fw-700\">#{self.ph}</code>" unless self.ph.blank?
    details << " <small>#{ApplicationController.helpers.boolean_icon self.is_valid, true_text: "valid", false_text: "invalid"}</small>." unless self.ph.blank?
    details << "Collection temperature: <code class=\"fw-700\">#{self.temperature}&deg; F</code>." unless self.temperature.blank?
    details << "Collection weight (10ml): <code class=\"fw-700\">#{self.weight}</code>." unless self.weight.blank?
    return details.join(" ")
  end

end