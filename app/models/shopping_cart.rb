class ShoppingCart < ApplicationRecord
  belongs_to :client, optional: true
  has_many :products_shopping_carts
  has_many :products, through: :products_shopping_carts

  def self.shop
    where(type: 'ShopCart')
  end

  def self.queue
    where(type: 'QueueCart')
  end
end
