require 'rails_helper'

describe Respondent do
  describe '#create' do
    let(:respondent) { create :respondent }
    let(:respondent_no_name) { create :respondent, :no_name }

    it 'creates a valid respondent' do
      expect(respondent).to_not be_nil
    end

    it 'creates a valid respondent without a name' do
      expect(respondent_no_name).to_not be_nil
    end
  end
end
