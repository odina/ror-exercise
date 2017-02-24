class Response < ActiveRecord::Base
  belongs_to :web_survey
  has_many :answers, dependent: :destroy
end
