class Attachment < ApplicationRecord

  # Allow uploads.
  has_one_attached  :file

  # Associations.
  belongs_to  :attachable,
              polymorphic: true,
              touch: true

  # Validations.
  validates :name,
            presence: true
  validates :file,
            presence: true
  validate  :validate_content_type

  # Callbacks.
  before_validation :set_attachment_name,
                    on: :create

  # Instance methods.

  # Validates file content type.
  def validate_content_type
    return unless self.file.attached?
    allowable_types = ::Attachment.allowable_content_types
    allowable_types = ::Attachment.allowable_image_types if self.only_images_allowed?
    return if allowable_types.include?(self.file.content_type)
    errors.add(:file, :content_type)
  end

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
    return unless self.name.blank?
    self.name = self.file.filename
  end

  # Class methods.

  # Returns allowed attachment types.
  def self.allowable_content_types
    return Attachment.allowable_image_types +
           Attachment.allowable_video_types +
           Attachment.allowable_audio_types +
           Attachment.allowable_other_types
  end

  # Returns allowed image attachment types.
  def self.allowable_image_types
    return ["image/bmp",
            "image/gif",
            "image/jpg",
            "image/jpeg",
            "image/png",
            "image/svg+xml",
            "image/tiff",
            "image/webp"]
  end

  # Returns allowed video attachment types.
  def self.allowable_video_types
    return ["video/mp4",
            "video/mpeg",
            "video/ogg",
            "video/quicktime",
            "video/webm",
            "video/x-msvideo"]
  end

  # Returns allowed audio attachment types.
  def self.allowable_audio_types
    return ["audio/aac",
            "audio/midi",
            "audio/mpeg",
            "audio/ogg",
            "audio/wav",
            "audio/webm",
            "audio/x-midi"]
  end

  # Returns allowed other attachment types.
  def self.allowable_other_types
    return ["application/json",
            "application/msword",
            "application/pdf",
            "application/rtf",
            "application/vnd.ms-excel",
            "application/vnd.ms-powerpoint",
            "application/vnd.openxmlformats-officedocument.presentationml.presentation",
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "application/xml",
            "application/zip",
            "text/csv",
            "text/html",
            "text/markdown",
            "text/plain",
            "text/xml"]
  end

end