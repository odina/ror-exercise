class Question < ActiveRecord::Base
  has_many :questions_web_surveys
  has_many :web_surveys, through: :questions_web_surveys
end
