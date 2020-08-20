class Guest < ApplicationRecord
  belongs_to :child
  has_many :orders, as: :orderable

  validates :name, presence: true
end
