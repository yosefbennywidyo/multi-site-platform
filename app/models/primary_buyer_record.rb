=begin
class PrimaryBuyerRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :primary_buyer, reading: :primary_buyer_replica }
end
=end