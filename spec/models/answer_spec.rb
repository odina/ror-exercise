require 'rails_helper'

describe Answer do
  describe '#create' do
    let(:answer) { create :answer }

    it 'creates a valid answer' do
      expect(answer).to_not be_nil
    end

    context 'when answer is blank' do
      before { answer.answer = nil }

      it 'renders answer invalid' do
        answer.invalid?

        expect(answer.errors[:answer]).to include("can't be blank!")
      end
    end
  end
end
