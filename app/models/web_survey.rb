class WebSurvey < ActiveRecord::Base
  belongs_to :user

  has_many :questions_web_surveys
  has_many :questions, through: :questions_web_surveys

  after_create :generate_slug

  private
  def generate_slug
    self.shortlink_slug = slug_or_random self.title
    self.save!
  end

  def slug_or_random(title)
    if title.blank?
      (0...10).map { ('a'..'z').to_a[rand(26)] }.join + "-%s"
    else
      title[0..30].downcase.gsub(/[^a-z1-9]+/, '-').chomp('-') + "-%s"
    end % Time.now.to_i.to_s # make it as unique as possible
  end
end
