class Records::SaltSprayCollectionRecord < Records::Result

  # Validations.
	validates	:temperature,
            :collection_1_amount,
            :collection_1_hours,
            :collection_2_amount,
            :collection_2_hours,
            presence: true,
            numericality: true

  # Callbacks.
  before_save :calculate_fields

  # Instance methods.

  # Calculates values before save.
  def calculate_fields
    self.collection_1_rate = self.collection_1_amount / self.collection_1_hours
    self.collection_2_rate = self.collection_2_amount / self.collection_2_hours
    self.collection_1_rate_valid = self.collection_1_rate.between?(1, 2)
    self.collection_2_rate_valid = self.collection_2_rate.between?(1, 2)
    self.is_valid = self.collection_1_rate_valid && self.collection_2_rate_valid
  end

  # Returns summary details for individual record.
  def details
    return <<-DETAILS
    Collection #1: <code class="fw-700">#{self.collection_1_amount} ml</code> in <code class="fw-700">#{self.collection_1_hours} hrs</code>
    (<code class="fw-700">#{ApplicationController.helpers.number_with_precision self.collection_1_rate, precision: 3} ml/hr</code>,
    <small>#{ApplicationController.helpers.boolean_icon self.collection_1_rate_valid, true_text: "valid", false_text: "invalid"}</small>).
    Collection #2: <code class="fw-700">#{self.collection_2_amount} ml</code> in <code class="fw-700">#{self.collection_2_hours} hrs</code>
    (<code class="fw-700">#{ApplicationController.helpers.number_with_precision self.collection_2_rate, precision: 3} ml/hr</code>,
    <small>#{ApplicationController.helpers.boolean_icon self.collection_2_rate_valid, true_text: "valid", false_text: "invalid"}</small>).
    DETAILS
  end

end