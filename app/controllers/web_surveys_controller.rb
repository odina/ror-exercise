class WebSurveysController < ApplicationController

  def show
    @web_survey = WebSurvey.find_by shortlink_slug: params[:slug]
  end
end
