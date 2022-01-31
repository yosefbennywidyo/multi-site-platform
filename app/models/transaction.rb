class Transaction < ApplicationRecord
  belongs_to :client
  belongs_to :bill

  def self.orders
    where(type: 'Order')
  end

  def self.queues
    where(type: 'Queue')
  end
end
