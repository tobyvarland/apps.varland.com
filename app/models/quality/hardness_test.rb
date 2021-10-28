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
  scope :with_part, ->(value) {
    return if value.blank?
    joins(:shop_order).where("`as400_shop_orders`.`part` = ?", value)
  }
  scope :with_process_code, ->(value) {
    return if value.blank?
    joins(:shop_order).where("`as400_shop_orders`.`process_code` = ?", value)
  }

  # Validations.
  validates :tested_on, :test_type, :piece_1, :piece_2, :piece_3, :piece_4, :piece_5,
            presence: true
  validates :load, 
            presence: true, 
            unless: Proc.new { |t| t.test_type == "Raw" }
  validates :load, 
            numericality: { only_integer: true, greater_than: 0 }, 
            allow_blank: true
  validates :piece_1, :piece_2, :piece_3, :piece_4, :piece_5,
            numericality: { greater_than: 0 }
  validates :test_type, 
            inclusion: { in: ["High Temp Bake", "Hydrogen Embrittlement Bake", "No Bake", "Raw", "Strip"] } 

  before_create  :link_raw_test
  after_save    :fix_tests_missing_raw
  before_discard  :nullify_raw_test_on_associated
  before_save   :nullify_load_for_raw_test

  def nullify_load_for_raw_test
    if self.test_type == "Raw"
      self.load = nil
      self.is_rework = nil
    end
  end

  def nullify_raw_test_on_associated
    Quality::HardnessTest.where(raw_test_id: self.id).update_all raw_test_id: nil
  end

  def fix_tests_missing_raw
    return unless self.test_type == "Raw"
      Quality::HardnessTest.where(shop_order_id: self.shop_order_id).where(raw_test_id: nil).where.not(test_type: "Raw").update_all(raw_test_id: self.id)
  end

  def link_raw_test
    return if self.test_type == "Raw"
    self.raw_test = Quality::HardnessTest.where(test_type: "Raw").where(shop_order_id: self.shop_order_id).first
  end

  def average
    return (self.piece_1 + self.piece_2 + self.piece_3 + self.piece_4 + self.piece_5) / 5
  end
  def change_from_raw
    return nil unless self.raw_test.present?
    return self.average  - self.raw_test.average
  end
  def load_with_rework
    if self.is_rework
      return "#{self.load}RW"
    else
      return self.load
    end
  end

   # Returns options for reject tag defect.
   def self.type_options
    return ["High Temp Bake", "Hydrogen Embrittlement Bake", "No Bake", "Raw", "Strip"].sort
  end

end


