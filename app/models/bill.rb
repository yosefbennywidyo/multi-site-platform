class Bill < ApplicationRecord
  belongs_to :buyer
  has_many :transactions

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

  def self.paid
    where(type: 'Paid')
  end

  def self.pending
    where(type: 'Pending')
  end
end
