class QuestionsWebSurvey < ActiveRecord::Base
  belongs_to :question
  belongs_to :web_survey
end
