require 'rails_helper'

describe Question do
  describe '#create' do
    let(:question) { create :question }

    it 'creates a valid question' do
      expect(question).to_not be_nil
    end
  end
end
