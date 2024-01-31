class Product < ApplicationRecord
  has_many :purchase_items
  has_many :purchases, through: :purchase_items

  has_one_attached :image

  def units_sold
    purchase_items.sum(:quantity)
  end
end
