class Product < ApplicationRecord
  belongs_to :seller, optional: true
  has_many :bills
  has_many :transactions
  has_many :product_details
end
