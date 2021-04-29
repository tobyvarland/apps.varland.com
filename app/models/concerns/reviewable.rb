module Reviewable

  extend ActiveSupport::Concern

  included do
    has_many  :reviews,
              as: :reviewable,
              class_name: "::Review"
  end

end