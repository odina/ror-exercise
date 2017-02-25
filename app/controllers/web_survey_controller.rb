class WebSurveyController < ApplicationController
  def answer
    @web_survey = WebSurvey.find_by shortlink_slug: params[:slug]
    @response = @web_survey.responses.build

    if request.get?
      @web_survey.questions.ordered.each { |q| @response.answers.build(question: q) }
    else
      @response = @web_survey.responses.build response_params

      if @response.save
        flash[:success] = 'Your answers have been submitted!'
      else
        flash[:error] = @response.errors.full_messages
      end
    end
  end

  private
  def response_params
    params.require(:response).permit(:name, answers_attributes: [:question_id, :answer])
  end
end
