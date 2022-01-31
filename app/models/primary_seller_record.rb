=begin
class PrimarySellerRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :primary_seller, reading: :primary_seller_replica }
end
=end