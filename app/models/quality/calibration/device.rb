class Quality::Calibration::Device < ApplicationRecord

  # Associations.
  belongs_to  :category,
              class_name: 'Quality::Calibration::Category'

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Scopes.

  # Validations.
  validates :name, 
            presence: true,
            uniqueness: { scope: :category_id, case_sensitive: false }
  validates :in_service_on,
            presence: true   
  validate  :ensure_in_service_date_not_in_future
            
  # Instance Methods

  # Ensures in service date not in future.
  def ensure_in_service_date_not_in_future
    return if self.in_service_on.blank?
    errors.add(:in_service_on, "cannot be in the future") if self.in_service_on > Date.current
  end

end