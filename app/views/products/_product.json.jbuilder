json.extract! product, :id, :name, :slug, :client_id, :created_at, :updated_at
json.url product_url(product, format: :json)
