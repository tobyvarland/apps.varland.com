class Quality::Calibration::Device < ApplicationRecord

  # Associations.
  belongs_to  :category,
              class_name: 'Quality::Calibration::Category'
  has_many    :results,
              class_name: 'Quality::Calibration::Result',
              foreign_key: 'device_id'

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Scopes.

  # Validations.
  validates :name,
            presence: true,
            uniqueness: { scope: :category_id, case_sensitive: false }

  # Instance Methods.

  # Saves calibration details before save.
  def store_calibration_details
    puts "🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴"
  end

end