module Commentable
  extend ActiveSupport::Concern

  included do
    # ASSOCIATIONS
    # -----------------

    has_many :comments, as: :commentable
  end
end
