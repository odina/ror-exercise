require 'test_helper'

class WebSurveysControllerTest < ActionController::TestCase
  setup do
    @web_survey = web_surveys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:web_surveys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create web_survey" do
    assert_difference('WebSurvey.count') do
      post :create, web_survey: { shortlink_slug: @web_survey.shortlink_slug, title: @web_survey.title }
    end

    assert_redirected_to web_survey_path(assigns(:web_survey))
  end

  test "should show web_survey" do
    get :show, id: @web_survey
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @web_survey
    assert_response :success
  end

  test "should update web_survey" do
    patch :update, id: @web_survey, web_survey: { shortlink_slug: @web_survey.shortlink_slug, title: @web_survey.title }
    assert_redirected_to web_survey_path(assigns(:web_survey))
  end

  test "should destroy web_survey" do
    assert_difference('WebSurvey.count', -1) do
      delete :destroy, id: @web_survey
    end

    assert_redirected_to web_surveys_path
  end
end
