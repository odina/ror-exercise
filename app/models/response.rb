class Response < ActiveRecord::Base
  belongs_to :web_survey
  belongs_to :respondent
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, :respondent
  accepts_nested_attributes_for :respondent # has to be after "answers"

  after_create :save_respondent

  def answers_attributes=(attributes)
    attributes.each_value do |params|
      answer = self.answers.build params
      answer.save
    end
  end

  def respondent_attributes=(attributes)
    self.respondent = Respondent.new attributes
  end

  # save only after_create, because it's possible
  # answers were blank, and a rollback happens
  def save_respondent
    self.respondent.save
  end
end
