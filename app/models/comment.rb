class Comment < ApplicationRecord
  # ASSOCIATIONS
  # -----------------

  belongs_to :commentable, polymorphic: true

  # VALIDATIONS
  # -----------------

  validates :content, presence: true
end
