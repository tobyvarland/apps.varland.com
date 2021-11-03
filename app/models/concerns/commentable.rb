module Commentable

  extend ActiveSupport::Concern

  included do

    scope :has_comments, ->(value) {
      case value
      when true, "true", 1, "1"
        where_assoc_exists(:comments)
      when false, "false", 0, "0"
        where_assoc_not_exists(:comments)
      end
    }
    scope :has_comment_attachments, ->(value) {
      case value
      when true, "true", 1, "1"
        where_assoc_exists([:comments, :attachments])
      when false, "false", 0, "0"
        where_assoc_not_exists([:comments, :attachments])
      end
    }
    scope :with_comment_containing, ->(value) { left_outer_joins(:comments).where("`comments`.`body` LIKE (?)", "%#{value}%") unless value.blank? }

    has_many  :comments,
              as: :commentable,
              class_name: "::Comment"
    has_many  :comment_attachments,
              through: :comments,
              class_name: "::Attachment",
              source: :attachments

  end

end