json.extract! response, :id, :name, :created_at, :updated_at
json.url response_url(response, format: :json)
