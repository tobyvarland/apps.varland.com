class Records::XrayCalibrationCheck < ApplicationRecord

  # Associations.
  belongs_to  :xray_weekly_check,
              class_name: "Records::XrayWeeklyCheck",
              foreign_key: "result_id",
              inverse_of: :xray_calibration_checks

  # Validations.
  validates	:name,
            :action,
            :position,
            presence: true
  validates :name,
            :position,
            uniqueness: { scope: :result_id, case_sensitive: false }
  validates :action,
            inclusion: { in: ["verified", "normalized", "recalibrated", "base_corrected"] }
  validates :position,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Scopes.
  default_scope -> { order(:position) }

  # Instance methods.

  # Returns details about this calibration.
  def to_s
    return self.details
  end
  def details
    return nil if self.action == "verified"
    return "#{self.name}: <code class=\"fw-700\">#{self.action.titleize}</code>."
  end

  # Defines table cell highlight classes.
  def table_cell_class
    case self.action
    when "normalized"
      return "bg-yellow-300"
    when "recalibrated"
      return "bg-green-300"
    end
    return nil
  end

  # Class methods.

  # Define actions.
  def self.actions_for_dropdown
    return [
      ["Verified", "verified"],
      ["Normalized", "normalized"],
      ["Recalibrated", "recalibrated"],
      ["Base Corrected", "base_corrected"]
    ].sort
  end

end