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

end