json.extract! web_survey, :id, :title, :shortlink_slug, :created_at, :updated_at
json.url web_survey_url(web_survey, format: :json)
