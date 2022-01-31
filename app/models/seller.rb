class Seller < Client
  has_many :products
  has_many :transactions
  
  def self.model_name
    superclass.model_name
  end
end