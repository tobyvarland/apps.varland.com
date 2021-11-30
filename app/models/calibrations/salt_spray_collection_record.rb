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

  # Returns collection rate for collection #1.
  def collection_1_rate
    return self.collection_1_amount / self.collection_1_hours
  end

  # Returns collection rate for collection #2.
  def collection_2_rate
    return self.collection_2_amount / self.collection_2_hours
  end

end