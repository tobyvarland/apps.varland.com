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

  # Callbacks.
  before_create :set_next_calibration_due_date

  # Instance Methods.

  # Return Device Details.
  def details
    fields = [{label: "Category", value: self.category.name}]
    fields << {label: "location", value: self.location} unless self.location.blank?
    return fields
  end

  # Default to Today.
  def set_next_calibration_due_date
    self.next_calibration_due_on = Date.current 
    self.calibration_due_status = "today"
  end

  # Saves calibration details before save.
  def store_calibration_details
    if self.results.length == 0
      self.last_calibrated_on = nil
      self.next_calibration_due_on = Date.current
    else
      self.last_calibrated_on = self.results.order(calibrated_on: :desc).first.calibrated_on
      self.next_calibration_due_on = self.last_calibrated_on + self.category.calibration_frequency.days
    end
    self.set_calibration_due_status
  end

  # Set calibration due status.
  def set_calibration_due_status
    if self.next_calibration_due_on < Date.current 
      self.calibration_due_status = "past_due"
    elsif self.next_calibration_due_on == Date.current 
      self.calibration_due_status = "today"
    elsif self.next_calibration_due_on < Date.current + 7.days 
      self.calibration_due_status = "next_week"
    elsif self.next_calibration_due_on < Date.current + 7.days 
      self.calibration_due_status = "next_month"
    else
      self.calibration_due_status = "future"
    end
    self.save
  end

end