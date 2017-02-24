json.extract! question, :id, :question, :is_default, :created_at, :updated_at
json.url question_url(question, format: :json)
