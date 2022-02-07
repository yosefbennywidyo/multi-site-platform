class Product < ApplicationRecord
  belongs_to :seller, optional: true
  has_many :bills
  has_many :transactions
  has_many :product_details
  has_many :products_shopping_carts
  has_many :shopping_carts, through: :products_shopping_carts
end
