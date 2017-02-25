require 'test_helper'

class WebSurveyControllerTest < ActionController::TestCase
  setup do
    @survey = web_surveys(:one)
  end

  test "should get /answer" do
    survey = WebSurvey.new @survey.attributes.slice(:title, :user_id)
    survey.save!

    get :answer, slug: survey.shortlink_slug
    assert_response :success
  end

  test "should post to /answer" do
    survey = WebSurvey.new @survey.attributes.slice(:title, :user_id)
    survey.save!

    params = {
      answers_attributes: {
        "0": {
          question_id: 1,
          answer: 'Yes'
        }
      },
      respondent_attributes: {
        name: 'Test'
      }
    }

    post :answer, { response: params, slug: survey.shortlink_slug }

    assert_not_nil flash[:success]
  end
end
