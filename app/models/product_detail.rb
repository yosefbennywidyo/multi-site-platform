class ProductDetail < ApplicationRecord
  belongs_to :product

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

  def self.releases
    where(type: 'Release')
  end

  def self.purchases
    where(type: 'Purchase')
  end
end
