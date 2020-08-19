class Order < ApplicationRecord
  self.ignored_columns = %w(child_id)
  belongs_to :product
  belongs_to :orderable, polymorphic: true

  validates :shipping_name, presence: true

  def to_param
    user_facing_id
  end
end
