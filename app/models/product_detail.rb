class ProductDetail < ApplicationRecord
  belongs_to :product, touch: true
  belongs_to :parent, class_name: 'ProductDetail', optional: true
  has_many :children, class_name: 'ProductDetail', foreign_key: 'parent_id'

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

  def self.parent
    where(parent_id: nil)
  end

  def self.children
    where.not(parent_id: nil)
  end
end
