class Quality::Calibration::Device < ApplicationRecord

  # Associations.
  belongs_to  :category,
              class_name: 'Quality::Calibration::Category'
  has_many    :calibrations, 
              class_name: 'Quality::Calibration::Calibrations', 
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

end