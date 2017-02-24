class Question < ActiveRecord::Base
  has_many :questions_web_surveys
  has_many :web_surveys, through: :questions_web_surveys

  QUESTION_TYPES = {
    1 => 'text_field',
    2 => 'text_area'
  }

  def type
    QUESTION_TYPES[self.question_type]
  end
end
