class WebSurvey < ActiveRecord::Base
  belongs_to :user
  has_many :responses, dependent: :destroy
  has_many :questions_web_surveys, dependent: :destroy
  has_many :questions, -> { uniq }, through: :questions_web_surveys

  after_create :generate_slug
  after_save :save_default_questions

  validate :max_2_custom_questions

  def max_2_custom_questions
    if self.questions.count > 2
      errors.add :questions, "can't be more than 2"
    end
  end

  private

  def save_default_questions
    default_questions = Question.where is_default: true
    default_questions.each { |q| self.questions << q }
  end

  def generate_slug
    self.shortlink_slug = if self.title.blank?
      (0...10).map { ('a'..'z').to_a[rand(26)] }.join + "-%s"
    else
      title[0..30].downcase.gsub(/[^a-z1-9]+/, '-').chomp('-') + "-%s"
    end % Time.now.to_i.to_s # make it as unique as possible

    self.save!
  end
end
