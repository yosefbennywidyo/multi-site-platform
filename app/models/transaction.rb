class Transaction < ApplicationRecord
  belongs_to :bill, optional: true
  belongs_to :product, optional: true
  belongs_to :parent, class_name: 'Transaction', optional: true
  has_many :children, class_name: 'Transaction', foreign_key: 'parent_id'

  def self.orders
    where(type: 'Order')
  end

  def self.queues
    where(type: 'Queue')
  end

  def self.parent
    where(parent_id: nil)
  end

  def self.children
    where.not(parent_id: nil)
  end
end
