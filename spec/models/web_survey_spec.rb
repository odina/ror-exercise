require 'rails_helper'

describe WebSurvey do
  describe '#create' do
    let(:survey) { create :web_survey }

    it 'creates a valid survey' do
      expect(survey).to_not be_nil
    end
  end

  describe '#slug' do
    it 'creates a shortlink slug' do
      survey_with_callback = FactoryGirl.build(:web_survey, title: 'Test')
      survey_with_callback.save!

      expect(survey_with_callback.shortlink_slug).to_not be_nil
    end
  end

  describe '#questions' do
    let(:survey) { create :web_survey }
    let(:question) { create :question }

    before do
      create :question, :default
    end

    it 'auto-adds default questions' do
      survey_with_callback = FactoryGirl.build(:web_survey, title: 'Test')
      survey_with_callback.save!

      expect(survey_with_callback.questions.count).not_to be 0
    end

    it 'can add up to 2 non-default questions' do
      survey.questions << create(:question)
      expect { survey.save! }.not_to raise_error

      survey.questions << create(:question)
      expect { survey.save! }.not_to raise_error
    end

    it "can't add more than 2 non-default questions" do
      survey.questions << create(:question)
      survey.questions << create(:question)
      survey.questions << create(:question)

      expect { survey.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "doesn't create duplicate question instances" do
      survey.questions << question
      survey.questions << question

      expect(survey.questions.non_default.count).to be 1
    end
  end
end
