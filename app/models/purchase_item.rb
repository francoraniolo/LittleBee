class PurchaseItem < ApplicationRecord
  belongs_to :purchase
  belongs_to :product

  def total_price
    quantity * product.price
  end
end
