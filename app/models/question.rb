class Question < ActiveRecord::Base
  has_many :questions_web_surveys, dependent: :destroy
  has_many :web_surveys, -> { uniq }, through: :questions_web_surveys
  has_many :answers

  scope :ordered, -> { order('id') }

  QUESTION_TYPES = {
    1 => 'text_field',
    2 => 'text_area'
  }

  def type
    QUESTION_TYPES[self.question_type]
  end

  # For use in rails_admin so "Question#id" shows us the actual question instead
  def name; self.question; end
end
