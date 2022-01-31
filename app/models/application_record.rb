class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  connects_to shards: {
    default: { writing: :primary, reading: :primary_replica },
    seller: { writing: :primary_seller, reading: :primary_seller_replica },
    buyer: { writing: :primary_buyer, reading: :primary_buyer_replica }
  }
end
