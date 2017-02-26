require 'rails_helper'

describe WebSurveyController do
  let(:survey) { create :web_survey }

  describe '#new_response' do
    context 'GET request' do
      it 'should allow get requests' do
        get :new_response, slug: survey.shortlink_slug

        expect(response.status).to eq(200)
      end

      it 'should redirect on invalid survey slug' do
        get :new_response, slug: 'this-is-invalid'

        expect(response.status).to eq(302)
        expect(flash[:error]).to_not be_nil
      end
    end
  end


  describe '#create_response' do
    context 'POST request' do
      let(:respondent) { create :respondent }

      let(:response_params) do
        { answers_attributes: {'0': attributes_for(:answer)},
          respondent_attributes: attributes_for(:respondent) }
      end

      let(:response_with_invalid_answers) do
        { answers_attributes: {'0': attributes_for(:answer, :blank)},
          respondent_attributes: attributes_for(:respondent) }
      end

      it 'should allow post requests' do
        post :create_response, slug: survey.shortlink_slug, response: response_params

        expect(response.status).to eq(302)
        expect(flash[:success]).to_not be_nil
      end

      it "shows error when form contains data that can't be saved" do
        post :create_response, slug: survey.shortlink_slug,
                               response: response_with_invalid_answers

        expect(response.status).to eq(200)
        expect(flash[:error]).to_not be_nil
      end
    end
  end
end
