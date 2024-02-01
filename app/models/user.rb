class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :purchases

  def current_purchase
    @current_purchase ||= find_or_create_current_purchase
  end

  private

  def find_or_create_current_purchase
    purchases.where(active: false).last || create_new_current_purchase
  end

  def create_new_current_purchase
    purchases.create(active: false, total_price: 0)
  end
end
