class Question < ActiveRecord::Base
  has_many :questions_web_surveys, dependent: :destroy
  has_many :web_surveys, -> { uniq }, through: :questions_web_surveys
  has_many :answers

  scope :ordered, -> { order('id') }
  scope :default, -> { where(is_default: true) }
  scope :non_default, -> { where(is_default: false) }

  QUESTION_TYPES = {
    1 => 'text_field',
    2 => 'text_area'
  }

  def type
    QUESTION_TYPES[self.question_type]
  end

  # For use in rails_admin
  def name; self.question; end
end
