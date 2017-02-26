class WebSurveyController < ApplicationController
  before_filter :get_web_survey, only: [:new_response, :create_response]

  def new_response
    if @web_survey

      @response = @web_survey.responses.build
      @web_survey.questions.each { |q| @response.answers.build(question: q) }

      render :new_response
    else
      flash[:error] = "No such survey exists!"
      redirect_to root_path
    end
  end

  def create_response
    @response = @web_survey.responses.build response_params

    if @response.save
      flash[:success] = 'Your answers have been submitted!'
      redirect_to root_path
    else
      flash[:error] = @response.errors.full_messages.to_sentence
      render :new_response
    end
  end

  private

  def response_params
    params.require(:response).permit(answers_attributes: [:question_id, :answer],
                                     respondent_attributes: [:name])
  end

  def get_web_survey
    @web_survey = WebSurvey.with_slug params[:slug]
  end
end
