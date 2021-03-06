class Response < ActiveRecord::Base
  belongs_to :web_survey
  belongs_to :respondent
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, :respondent

  scope :ordered_by_name, -> { joins(:respondent).order('LOWER(respondents.name), respondents.id') }

  def answers_attributes=(attributes)
    attributes.each_value do |params|
      answer = self.answers.build params
    end
  end

  def respondent_attributes=(attributes)
    self.respondent = Respondent.new attributes
  end

  def respondent_name
    respondent.name.presence || "Anonymous # #{respondent.id}"
  end

  # For use in rails_admin
  def name; self.respondent_name; end
end
