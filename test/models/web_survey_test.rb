require 'test_helper'

class WebSurveyTest < ActiveSupport::TestCase
  setup do
    survey = web_surveys(:one)

    @survey = WebSurvey.new survey.attributes.slice(:title, :user_id)
    @survey.save

    @question = questions(:two)
  end

  test 'can create WebSurvey' do
    assert_not_nil @survey
  end

  test 'create shortlink_slug' do
    survey = WebSurvey.new @survey.attributes.slice(:title, :user_id)
    survey.save

    assert_not_nil survey.shortlink_slug
  end

  test 'auto-adds default questions' do
    assert @survey.questions.count > 0
  end

  test "can add custom questions" do
    survey = WebSurvey.new @survey.attributes.slice(:title, :user_id)
    survey.questions << questions(:two)
    survey.questions << questions(:three)

    assert survey.save!
  end

  test "can't add more than 2 custom questions" do
    survey = WebSurvey.new @survey.attributes.slice(:title, :user_id)

    survey.questions << questions(:two)
    survey.questions << questions(:three)
    survey.questions << questions(:four)

    assert_raises ActiveRecord::RecordInvalid do
      survey.save!
    end
  end

  test "doesn't create duplicates of questions" do
    survey = WebSurvey.new @survey.attributes.slice(:title, :user_id)

    question = @question

    survey.questions << question
    survey.questions << question
    survey.save!

    questions = survey.questions.where(id: question.id)

    assert questions.count == 1
  end
end
