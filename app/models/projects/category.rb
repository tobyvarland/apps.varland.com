class Projects::Category < ApplicationRecord

  # Soft Deletes.
  include Discard::Model
  default_scope -> { kept }

  # Associations.
  belongs_to  :system,
              class_name: "Projects::System",
              foreign_key: "system_id",
              inverse_of: :categories     
  has_many    :items,
              class_name: "Projects::Item",
              foreign_key: "category_id",
              inverse_of: :category,
              dependent: :restrict_with_error       

  # Validations.
  validates :name, 
            presence: true,
            uniqueness: {case_sensitive: false, scope: :system_id }
  validates	:abbreviation,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[a-z0-9_]+\z/ },
            length: { in: 2..15 } 
  validates :last_number_used, 
            presence: true,
            numericality: { only_integer: true }

  # Callbacks.
  before_validation :initialize_last_number_used, on: :create

  # Instance Methods.

  # Initialize to 0.
  def initialize_last_number_used
    self.last_number_used = 0
  end
          
end