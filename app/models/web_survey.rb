class WebSurvey < ActiveRecord::Base
  belongs_to :user
  has_many :responses, dependent: :destroy
  has_many :questions_web_surveys, dependent: :destroy
  has_many :questions, -> { uniq }, through: :questions_web_surveys

  after_create :generate_slug
  after_save :save_default_questions

  validate :max_2_custom_questions
  validates_uniqueness_of :shortlink_slug

  scope :all_with_slug, -> (slug) { where(shortlink_slug: slug) }

  def self.with_slug(slug)
    self.all_with_slug(slug).first
  end

  def max_2_custom_questions
    if self.questions.non_default.count > 2
      errors.add :questions, "can't be more than 2"
    end
  end

  private

  def save_default_questions
    default_questions = Question.default
    default_questions.each { |q| self.questions << q unless self.questions.include?(q) }
  end

  def generate_slug
    slug = self.title.presence || 'untitled'
    slug += "-%s" % SecureRandom.hex

    self.shortlink_slug = slug
    self.save!
  end
end
