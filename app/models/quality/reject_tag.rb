class Quality::RejectTag < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Associations.
  include Attachable
  include Commentable
  belongs_to  :shop_order,
              class_name: 'As400::ShopOrder'
  belongs_to  :user,
              class_name: "::User"
  belongs_to  :source,
              class_name: "Quality::RejectTag",
              optional: true
  has_many    :loads,
              class_name: "Quality::RejectTagLoad",
              inverse_of: :reject_tag

  # Nested attributes.
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :loads, reject_if: :all_blank, allow_destroy: true

  # Scopes.
  scope :with_shop_order, ->(value) {
    return if value.blank?
    joins(:shop_order).where("`as400_shop_orders`.`number` = ?", value)
  }

  # Validations.
  validates :number, :rejected_on, :loads_rejected, :pounds, :defect, :cause, :department,
            presence: true

  # Callbacks.
  before_validation :nullify_source
  after_create      :update_as400_count
  after_discard     :update_as400_count
  after_undiscard   :update_as400_count

  # Instance methods.

  # Updates reject tag count on System i.
  def update_as400_count
    self.shop_order.set_as400_reject_tag_count
  end

  # Returns description.
  def description
    "#{self.shop_order.number}##{self.number}"
  end

  # Set source to null if set to -1.
  def nullify_source
    return unless self.source_id == -1
    self.source_id = nil
  end

  # Returns shop order number.
  def shop_order_number
    return nil unless self.shop_order.present?
    return self.shop_order.number
  end

  # Sets shop order association from shop order number.
  def shop_order_number=(value)
    self.shop_order = As400::ShopOrder.from_as400(value)
  end

  # Returns user name.
  def user_name
    return nil unless self.user.present?
    return self.user.name
  end

  # Class methods.

  # Returns options for department.
  def self.department_options
    return [["3 - Department 3", 3],
            ["4 - BNA", 4],
            ["5 - Dept. 5", 5],
            ["6 - Bead Blast", 6],
            ["7 - Bake", 7],
            ["8 - Robot", 8],
            ["9 - Strip", 9],
            ["10 - Miscellaneous", 10],
            ["11 - Oil Dip", 11],
            ["12 - EN", 12]]
  end

  # Returns options for reject tag cause.
  def self.cause_options
    return ["Cleaning", "Customer Issue", "Development", "Equipment", "Operator Error", "Opto", "Part Related", "S.O. Procedure", "Solution", "Technique", "Technology", "Unknown", "Wrong Process"].sort
  end

  # Returns options for reject tag defect.
  def self.defect_options
    return ["Adhesion", "Alloy", "Appearance", "Arced", "Built Up", "Chromate", "Coverage", "Not Clean", "Other", "Post Dip", "Thickness", "Wrong Process"].sort
  end

  # Returns options for reject tag permission.
  def self.permission_options
    return [["No Access", 0], ["View Only", 1], ["Create New", 2], ["Full Access", 3]]
  end

  # Returns options for source field for given shop order number.
  def self.source_options_for_shop_order(value)
    options = [["Original S.O.", -1]]
    tags = Quality::RejectTag.with_shop_order(value).order(:number)
    tags.each do |tag|
      options << [tag.description, tag.id]
    end
    return options
  end

  # Returns options for source field for given reject tag id.
  def self.source_options_for_tag(tag)
    options = [["Original S.O.", -1]]
    return options if tag.id.blank?
    tags = Quality::RejectTag.where(shop_order_id: tag.shop_order_id).where("number < ?", tag.number).order(:number)
    tags.each do |tag|
      options << [tag.description, tag.id]
    end
    return options
  end

end