module Attachable

  extend ActiveSupport::Concern

  included do
    has_many  :attachments,
              as: :attachable,
              class_name: "::Attachment",
              inverse_of: :attachable
  end

end