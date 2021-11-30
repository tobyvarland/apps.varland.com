class Calibrations::SaltSprayCollectionRecord < Calibrations::Result

  # Validations.
	validates	:temperature,
            :collection_1_amount,
            :collection_1_hours,
            :collection_2_amount,
            :collection_2_hours,
            presence: true,
            numericality: true

  # Instance methods.

  # Returns summary details for individual calibration.
  def details
    return <<-DETAILS
    Collection #1: <code class="fw-700">#{self.collection_1_amount} ml</code> in <code class="fw-700">#{self.collection_1_hours} hrs</code>
    (<code class="fw-700">#{ApplicationController.helpers.number_with_precision self.collection_1_rate, precision: 3} ml/hr</code>,
    <small>#{ApplicationController.helpers.boolean_icon self.collection_1_rate.between?(1, 2), true_text: "valid", false_text: "invalid"}</small>).
    Collection #2: <code class="fw-700">#{self.collection_2_amount} ml</code> in <code class="fw-700">#{self.collection_2_hours} hrs</code>
    (<code class="fw-700">#{ApplicationController.helpers.number_with_precision self.collection_2_rate, precision: 3} ml/hr</code>,
    <small>#{ApplicationController.helpers.boolean_icon self.collection_2_rate.between?(1, 2), true_text: "valid", false_text: "invalid"}</small>).
    DETAILS
  end

  # Returns collection rate for collection #1.
  def collection_1_rate
    return self.collection_1_amount / self.collection_1_hours
  end

  # Returns collection rate for collection #2.
  def collection_2_rate
    return self.collection_2_amount / self.collection_2_hours
  end

end