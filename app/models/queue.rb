class Queue < Transaction
  def self.model_name
    superclass.model_name
  end
end