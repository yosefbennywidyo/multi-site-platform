module Tenantable
  extend ActiveSupport::Concern
 
  private
 
  def read_with_tenant(&block) 
    ActiveRecord::Base.connected_to(role: :reading, shard: request.subdomain.to_sym) do
      block.call
    end
  end

  def read_default_with_tenant(&block) 
    ActiveRecord::Base.connected_to(role: :reading, shard: :default) do
      block.call
    end
  end

  def read_seller_with_tenant(&block) 
    ActiveRecord::Base.connected_to(role: :reading, shard: :seller) do
      block.call
    end
  end

  def read_buyer_with_tenant(&block) 
    ActiveRecord::Base.connected_to(role: :reading, shard: :buyer) do
      block.call
    end
  end

  def write_with_tenant(&block) 
    ActiveRecord::Base.connected_to(role: :writing, shard: request.subdomain.to_sym) do
      block.call
    end
  end

  def write_to_default_with_tenant(&block) 
    ActiveRecord::Base.connected_to(role: :writing, shard: :default) do
      block.call
    end
  end

  def write_to_seller_with_tenant(&block) 
    ActiveRecord::Base.connected_to(role: :writing, shard: :seller) do
      block.call
    end
  end

  def write_to_buyer_with_tenant(&block) 
    ActiveRecord::Base.connected_to(role: :writing, shard: :buyer) do
      block.call
    end
  end
 end