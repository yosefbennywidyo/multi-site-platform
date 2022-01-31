class Buyer < Client
  has_many :bills
  
  def self.model_name
    superclass.model_name
  end
end