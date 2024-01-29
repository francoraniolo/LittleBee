class Purchase < ApplicationRecord
  has_many :purchase_items
  has_many :products, through: :purchase_items
end
