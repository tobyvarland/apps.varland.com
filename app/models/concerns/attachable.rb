module Attachable

  extend ActiveSupport::Concern

  included do

    scope :has_attachments, ->(value) {
      case value
      when true, "true", 1, "1"
        where_assoc_exists(:attachments)
      when false, "false", 0, "0"
        where_assoc_not_exists(:attachments)
      end
    }

    has_many  :attachments,
              as: :attachable,
              class_name: "::Attachment",
              inverse_of: :attachable,
              dependent: :destroy

  end

end