class Quality::HardnessTest < ApplicationRecord

  # Concerns.
  include ShopOrderAssignable

  # Track changes.
  has_paper_trail

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Associations.
  include Commentable
  belongs_to  :shop_order,
              class_name: 'AS400::ShopOrder'
  belongs_to  :user,
              class_name: "::User"
  belongs_to  :raw_test,
              class_name: "Quality::HardnessTest",
              optional: true



  # Scopes.
  scope :with_average_gte, ->(value) {
    return if value.blank?
    where("average >= ?", value)
  }
  scope :with_average_lte, ->(value) {
    return if value.blank?
    where("average <= ?", value)
  }
  scope :on_or_after, ->(value) {
    return if value.blank?
    where("tested_on >= ?", value)
  }
  scope :on_or_before,  ->(value) {
    return if value.blank?
    where("tested_on <= ?", value)
  }
  scope :with_test_type, ->(value) {
    return if value.blank?
    where(test_type: value)
  }
  scope :with_oven_type, ->(value) {
    return if value.blank?
    where(oven_type: value)
  }
  scope :with_load, ->(value) {
    return if value.blank?
    where(load: value)
  }
  scope :with_is_rework, ->(value) {
    return if value.nil?
    if value == true || value == "true"
      where(is_rework: value)
    else
      where("is_rework IS FALSE OR is_rework IS NULL")
    end
  }
  scope :sorted_by, ->(value) {
    return if value.blank?
    case value
    when "newest"
      joins(:shop_order).order("`quality_hardness_tests`.`tested_on` DESC, `as400_shop_orders`.`customer_code` ASC, `as400_shop_orders`.`process_code` ASC, `as400_shop_orders`.`part` ASC, `as400_shop_orders`.`sub` ASC, `as400_shop_orders`.`number` ASC")
    when "oldest"
      joins(:shop_order).order("`quality_hardness_tests`.`tested_on`, `as400_shop_orders`.`customer_code`, `as400_shop_orders`.`process_code`, `as400_shop_orders`.`part`, `as400_shop_orders`.`sub`, `as400_shop_orders`.`number`")
    when "highest_average"
      joins(:shop_order).order("`quality_hardness_tests`.`average` DESC, `as400_shop_orders`.`customer_code` ASC, `as400_shop_orders`.`process_code` ASC, `as400_shop_orders`.`part` ASC, `as400_shop_orders`.`sub` ASC, `as400_shop_orders`.`number` ASC")
    when "lowest_average"
      joins(:shop_order).order("`quality_hardness_tests`.`average`, `as400_shop_orders`.`customer_code`, `as400_shop_orders`.`process_code`, `as400_shop_orders`.`part`, `as400_shop_orders`.`sub`, `as400_shop_orders`.`number`")
    when "part_spec"
      by_part_spec
    when "shop_order"
      by_shop_order
    end
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
  validate  :require_smalog
  validates :oven_type,
            inclusion: { in: ["JPW", "Grieve"] },
            allow_blank: true

  before_create   :link_raw_test
  after_save      :fix_tests_missing_raw
  before_discard  :nullify_raw_test_on_associated
  before_save     :nullify_load_for_raw_test
  before_save     :calculate_average

  def require_smalog
    return if self.shop_order.blank?
    errors.add(:base, "Shop order is from a customer other than SMALOG") unless self.shop_order.customer_code == "SMALOG"
  end

  def individual_pieces
    [self.piece_1, self.piece_2, self.piece_3, self.piece_4, self.piece_5]
  end

  def description
    if self.test_type == "Raw"
      "S.O. ##{self.shop_order_number}, #{self.test_type}"
    else
      "S.O. ##{self.shop_order_number}, Load ##{self.load_with_rework}, #{self.test_type}"
    end
  end

  def calculate_average
    self.average = (self.piece_1 + self.piece_2 + self.piece_3 + self.piece_4 + self.piece_5) / 5
  end

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

  # Returns options for oven type. 
  def self.oven_type_options
    return ["JPW", "Grieve"]
  end

  # Returns options for reject tag permission.
  def self.permission_options
    return [["No Access", 0], ["View Only", 1], ["Create New", 2], ["Full Access", 3]]
  end

end