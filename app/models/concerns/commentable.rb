module Commentable

  extend ActiveSupport::Concern

  included do
    has_many  :comments,
              as: :commentable
    has_many  :comment_attachments,
              through: :comments,
              class_name: "Attachment",
              source: :attachments
  end

end