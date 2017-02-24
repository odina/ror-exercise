class Response < ActiveRecord::Base
  belongs_to :web_survey
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers

  def answers_attributes=(attributes)
    attributes.each_value do |params|
      answer = self.answers.build params
      answer.save
    end
  end
end
