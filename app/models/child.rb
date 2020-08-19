class Child < ApplicationRecord
  has_many :orders, as: :orderable
end
