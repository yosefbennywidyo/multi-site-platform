json.extract! transaction, :id, :client_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
