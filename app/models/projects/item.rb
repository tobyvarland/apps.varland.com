class Projects::Item < ApplicationRecord

  # Associations.
  belongs_to  :category,
              class_name: "Projects::Category",
              foreign_key: "category_id",
              inverse_of: :items 
              
  # Validations.
  validates   :current_status,
              presence: true,
              inclusion: { in: ["requested", "opened", "close_requested", "closed", "deleted", "reopened", "held"] }
  validates   :current_status_at,
              presence: true
  validates   :percent_complete,
              numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, 
              allow_blank: true     
  validates   :projected_hours,
              numericality: { greater_than: 0 }, 
              allow_blank: true
  validate    :require_valid_priority

  # Callbacks.
  after_create_commit :set_item_number

  # Instance Methods.

  # Sets item number to next available for category. 
  def set_item_number
    ActiveRecord::Base.transaction do 
      self.number = self.category.last_number_used + 1
      self.save
      self.category.last_number_used = self.number
      self.category.save
    end
  end
  
  # Validates priority against category. 
  def require_valid_priority
    if self.category.blank? || !self.category.use_priorities
      self.errors.add(:current_priority_at, "must be blank") unless self.current_priority_at.blank?
      self.errors.add(:current_priority, "must be blank") unless self.current_priority.blank?
    else
      self.errors.add(:current_priority_at, "can't be blank") if self.current_priority_at.blank?
      self.errors.add(:current_priority, "is invalid") unless [1, 2, 3].include?(self.current_priority)
    end
  end

end