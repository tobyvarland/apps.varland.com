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
    fields << {label: "Location", value: self.location} unless self.location.blank?
    fields << {label: "Calibration Status", value: ApplicationController.helpers.calibration_status_badge(self.calibration_due_status)}
    fields << {label: "In Service On", value: self.in_service_on.strftime("%m/%d/%y")}
    fields << {label: "Retired On", value: self.retired_on.strftime("%m/%d/%y")} unless self.retired_on.blank?
    fields << {label: "Last Calibrated On", value: self.last_calibrated_on.strftime("%m/%d/%y")} unless self.last_calibrated_on.blank?
    fields << {label: "Next Calibration Due On", value: self.next_calibration_due_on.strftime("%m/%d/%y")} unless self.next_calibration_due_on.blank?
    return fields
  end

  # Default to Today.
  def set_next_calibration_due_date
    if self.category.calibration_frequency.blank?
      self.calibration_due_status = "none"
    else  
      self.next_calibration_due_on = Date.current 
      self.calibration_due_status = "today"
    end
  end

  # Saves calibration details before save.
  def store_calibration_details
    if self.results.length == 0
      self.last_calibrated_on = nil
      unless self.category.calibration_frequency.blank?
        self.next_calibration_due_on = Date.current
      end
    else
      self.last_calibrated_on = self.results.order(calibrated_on: :desc).first.calibrated_on
      unless self.category.calibration_frequency.blank?
        self.next_calibration_due_on = self.last_calibrated_on + self.category.calibration_frequency.days
      end
    end
    self.set_calibration_due_status
  end

  # Set calibration due status.
  def set_calibration_due_status
    if self.next_calibration_due_on.nil? 
      self.calibration_due_status = "none"
    elsif self.next_calibration_due_on < Date.current 
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