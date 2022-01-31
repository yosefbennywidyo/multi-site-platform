json.extract! client, :id, :slug, :name, :created_at, :updated_at
json.url client_url(client, format: :json)
