class Client < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :name, presence: true
  validates :email, uniqueness: true
  validates :name, uniqueness: true
  validates :password, presence: true

  has_one :shopping_cart

  scope :exclude, -> (*values) { 
    where(
      "#{table_name}.id NOT IN (?)",
        (
          values.compact.flatten.map { |e|
            if e.is_a?(Integer) 
              e
            else
              e.is_a?(self) ? e.id : raise("Element not the same type as #{self}.")
            end
          } << 0
        )
      )
    }

  def self.buyers
    where(type: 'Buyer')
  end

  def self.sellers
    where(type: 'Seller')
  end
  
  def buyer?
    type.eql?('Buyer')
  end

  def seller?
    type.eql?('Seller')
  end
end
