class ShiftNote < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Associations.
  include Attachable
  include Commentable
  belongs_to  :user,
              class_name: "::User"

  # Nested attributes.
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  # Scopes.
  include TextSearchable
  scope :with_shift, ->(value) { where(shift: value) unless value.blank? }
  scope :with_department, ->(value) { where(department: value) unless value.blank? }
  scope :for_department, ->(symbol, value) {
    case value
    when true, "true", 1, "1"
      where("#{symbol} IS TRUE")
    when false, "false", 0, "0"
      where.not("#{symbol} IS TRUE")
    end
  }
  scope :for_it, ->(value) { for_department(:is_for_it, value) }
  scope :for_lab, ->(value) { for_department(:is_for_lab, value) }
  scope :for_maintenance, ->(value) { for_department(:is_for_maintenance, value) }
  scope :for_plating, ->(value) { for_department(:is_for_plating, value) }
  scope :for_qc, ->(value) { for_department(:is_for_qc, value) }
  scope :for_shipping, ->(value) { for_department(:is_for_shipping, value) }
  scope :entered_by, ->(value) { where(user_id: value) unless value.blank? }
  scope :on_or_after, ->(value) { where("note_on >= ?", value) unless value.blank? }
  scope :on_or_before,  ->(value) { where("note_on <= ?", value) unless value.blank? }
  scope :sorted_by, ->(value) {
    value = "newest" if value.blank?
    case value
    when "newest"
      order(note_on: :desc, shift: :desc)
    when "oldset"
      order(:note_on, :shift)
    end
  }
  scope :has_any_attachments, ->(value) {
    case value
    when true, "true", 1, "1"
      has_attachments(true).or(has_comment_attachments(true))
    when false, "false", 0, "0"
      has_attachments(false).has_comment_attachments(false)
    end
  }
  scope :with_search_term, ->(value) {
    return if value.blank?
    note_ids = ShiftNote.with_text_containing(:notes, value).pluck(:id)
    comment_ids = ShiftNote.with_text_containing("`comments`.`body`", value, join_table: :comments).pluck(:id)
    where(id: [note_ids + comment_ids].uniq)
  }

  # Validations.
  validates :note_on, :shift, :notes,
            presence: true
  validates :shift,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 2 }
  validates :department,
            numericality: { only_integer: true },
            allow_blank: true

  # Callbacks.
  after_create  :send_email_notification

  # Instance methods.

  # Handles notifications.
  def send_email_notification
    # ShiftNoteMailer.with(shift_note: self).notification_email.deliver_later
  end

  # Returns department name for number.
  def department_name(options = {})
    without_number = options.fetch :without_number, false
    name = nil
    ShiftNote.department_options.each do |opt|
      name = opt[0] if self.department == opt[1]
    end
    if !name.blank? && without_number
      name = name.split(" - ")[1]
    end
    return name
  end

  # Returns user name.
  def user_name
    return nil unless self.user.present?
    return self.user.name
  end

  # Class methods.

  # Returns options for department.
  def self.department_options(options = {})
    limit = options.fetch :limit, false
    names = [["3 - Department 3", 3],
             ["4 - BNA", 4],
             ["5 - Dept. 5", 5],
             ["6 - Bead Blast", 6],
             ["7 - Bake", 7],
             ["8 - Robot", 8],
             ["9 - Strip", 9],
             ["10 - Miscellaneous", 10],
             ["11 - Oil Dip", 11],
             ["12 - EN", 12],
             ["30 - Waste Water", 30]]
    if limit
      return names.reject {|n| !limit.include?(n[1])}
    else
      return names
    end
  end

end