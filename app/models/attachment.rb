class Attachment < ApplicationRecord

  # Allow uploads.
  has_one_attached  :file

  # Associations.
  belongs_to  :attachable,
              polymorphic: true

  # Validations.
  validates :name,
            presence: true
  validates :file,
            presence: true
  validates :file,
            blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'] },
            if: :only_images_allowed?

  # Callbacks.
  before_validation :set_attachment_name,
                    on: :create

  # Instance methods.

  # Determines if only image attachments allowed.
  def only_images_allowed?
    return false if self.attachable_type.blank?
    case self.attachable_type
    when "Quality::RejectTag"
      return true
    else
      return false
    end
  end

  # Sets name field for attachment record.
  def set_attachment_name
    return unless self.file.attached?
    self.name = self.file.filename
  end

end