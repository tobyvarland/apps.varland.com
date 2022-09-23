class Bake::StandardProcedure < ApplicationRecord

  # Validations.
  validates :name, :setpoint, :minimum, :maximum, :soak_hours,
            presence: true
  validates :name,
            uniqueness: true,
            allow_blank: true
  validates :process_codes,
            format: { with: /\A[A-Z]{1,3}(,[A-Z]{1,3})*\z/, message: "must be a comma separated list of process codes (in all caps)" },
            allow_blank: true
  validates :setpoint, :minimum, :maximum,
            numericality: { only_integer: true, greater_than: 0 },
            allow_blank: true
  validates :soak_hours, :within_hours,
            numericality: { greater_than: 0 },
            allow_blank: true

end