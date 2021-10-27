class Quality::HardnessTest < ApplicationRecord

  # Concerns.
  include ShopOrderAssignable


  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Associations.
  belongs_to  :shop_order,
              class_name: 'AS400::ShopOrder'
  belongs_to  :user,
              class_name: "::User"
  belongs_to  :raw_test,
              class_name: "Quality::HardnessTest",
              optional: true

  # Scopes.
  scope :with_shop_order, ->(value) {
    return if value.blank?
    joins(:shop_order).where("`as400_shop_orders`.`number` = ?", value)
  }

  # Validations.
  validates :tested_on, :load, :test_type, :piece_1, :piece_2, :piece_3, :piece_4, :piece_5,
            presence: true
  validates :load, 
            numericality: { only_integer: true, greater_than: 0 }
  validates :piece_1, :piece_2, :piece_3, :piece_4, :piece_5,
            numericality: { greater_than: 0 }
  validates :test_type, 
            inclusion: { in: ["High Temp Bake", "Hydrogen Embrittlement Bake", "No Bake", "Raw", "Strip"] } 

  after_initialize  :set_field_defaults
  before_create  :link_raw_test

  def link_raw_test
    return if self.test_type == "Raw"
    self.raw_test = Quality::HardnessTest.where(test_type: "Raw").where(shop_order_id: self.shop_order_id).first
  end

  def set_field_defaults
    self.tested_on = Date.current
    self.is_rework = false
  end

  def average
    return (self.piece_1 + self.piece_2 + self.piece_3 + self.piece_4 + self.piece_5) / 5
  end
  def change_from_raw
    return nil unless self.raw_test.present?
    return self.average  - self.raw_test.average
  end

   # Returns options for reject tag defect.
   def self.type_options
    return ["High Temp Bake", "Hydrogen Embrittlement Bake", "No Bake", "Raw", "Strip"].sort
  end

end


