class WebSurveyController < ApplicationController
  def answer
    @web_survey = WebSurvey.with_slug(params[:slug])

    if @web_survey
      @response = @web_survey.responses.build

      if request.get?
        @web_survey.questions.ordered.each { |q| @response.answers.build(question: q) }
      else
        @response = @web_survey.responses.build response_params

        if @response.save
          flash[:success] = 'Your answers have been submitted!'
          redirect_to root_path
        else
          flash[:error] = @response.errors.full_messages.to_sentence
        end
      end
    else
      flash[:error] = "No such survey exists!"
      redirect_to root_path
    end
  end

  private
  def response_params
    params.require(:response).permit(answers_attributes: [:question_id, :answer],
                                     respondent_attributes: [:name])
  end
end
