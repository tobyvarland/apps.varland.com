class EmployeeNote < ApplicationRecord

  # Soft deletes.
  include Discard::Model
  default_scope -> { kept }

  # Track changes.
  has_paper_trail

  # Associations.
  include Attachable
  include Commentable
  belongs_to  :user,
              class_name: "::User"
  has_many    :employee_note_subjects,
              class_name: "::EmployeeNoteSubject",
              dependent: :delete_all
  has_many    :subjects,
              class_name: "::User",
              through: :employee_note_subjects,
              source: :users

  # Nested attributes.
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :employee_note_subjects, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :comments, reject_if: :all_blank, allow_destroy: true

  # Scopes.
  include TextSearchable
  scope :entered_by, ->(value) { where(user_id: value) unless value.blank? }
  scope :on_or_after, ->(value) { where("note_on >= ?", value) unless value.blank? }
  scope :on_or_before,  ->(value) { where("note_on <= ?", value) unless value.blank? }
  scope :sorted_by, ->(value) {
    value = "newest" if value.blank?
    case value
    when "newest"
      order(note_on: :desc)
    when "oldest"
      order(:note_on)
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
    note_ids = EmployeeNote.with_text_containing(:notes, value).pluck(:id)
    comment_ids = EmployeeNote.with_text_containing("`comments`.`body`", value, join_table: :comments).pluck(:id)
    where(id: [note_ids + comment_ids].uniq)
  }
  scope :with_subject, ->(value) {
    where_assoc_exists(:employee_note_subjects, user_id: value) unless value.blank?
  }
  scope :with_note_type, ->(value) {
    where_assoc_exists(:employee_note_subjects, note_type: value) unless value.blank?
  }
  scope :with_subject_and_type, ->(values) {
    subject = values[0]
    type = values[1]
    where_assoc_exists(:employee_note_subjects, user_id: subject, note_type: type) unless subject.blank? || type.blank?
  }

  # Validations.
  validates :note_on, :notes,
            presence: true
  validate  :must_include_subject

  # Instance methods.

  # Require subject when creating note.
  def must_include_subject
    errors.add(:base, "You must include at least one employee in this note.") if self.employee_note_subjects.length == 0
  end

  # Returns user name.
  def user_name
    return nil unless self.user.present?
    return self.user.name
  end

  # Class methods.

end
