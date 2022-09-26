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

  # Instance methods.

  # Returns description for dropdown.
  def description
    parts = [
      "#{self.name}:",
      "#{self.setpoint}&deg; F for #{ApplicationController.helpers.pluralize self.soak_hours, "hour"}",
      "(#{self.minimum}&deg; F min / #{self.maximum}&deg; F max)"
    ]
    parts << "[Within #{ApplicationController.helpers.pluralize self.within_hours, "hour"}]" unless self.within_hours.blank?
    parts << "[Profile: #{self.profile_name}]" unless self.profile_name.blank?
    return parts.join " "
  end

end