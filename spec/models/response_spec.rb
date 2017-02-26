require 'rails_helper'

describe Response do
  describe '#answers' do
    let(:response) { create :response }
    let(:answer) { create :answer }

    before do
      response.answers = [answer]
    end

    context 'answers are valid' do
      it 'creates a valid response' do
        expect(response).to_not be_nil
      end
    end

    context 'answers are blank' do
      it 'renders response invalid' do
        invalid_answer = response.answers.build attributes_for(:answer, :blank)

        expect { invalid_answer.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
