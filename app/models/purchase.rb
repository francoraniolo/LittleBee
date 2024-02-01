class Purchase < ApplicationRecord
  belongs_to :user
  has_many :purchase_items, dependent: :destroy
  has_many :products, through: :purchase_items

  def self.active
    where(active: true)
  end

  def add_product(product, quantity)
    @purchase_item = find_or_create_purchase_item(product)
    @purchase_item.update(quantity: @purchase_item.quantity + quantity)
    @purchase_item
  end

  def find_quantity_from_item(product)
    item = purchase_items.find_by(product: product)

    item ? item.quantity : 0
  end

  private

  def find_or_create_purchase_item(product)
    purchase_items.find_by(product: product) || create_new_purchase_item(product)
  end

  def create_new_purchase_item(product)
    purchase_items.create(product: product, quantity: 0)
  end
end
