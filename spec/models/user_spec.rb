require 'rails_helper'

describe User do
  describe '#create' do
    let(:user) { create :user }

    it 'creates a valid user' do
      expect(user).to_not be_nil
    end
  end
end
