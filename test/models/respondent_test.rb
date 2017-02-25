require 'test_helper'

class RespondentTest < ActiveSupport::TestCase
  test 'can create respondent with name' do
    respondent = Respondent.new name: 'John Doe'
    assert respondent.save!
  end

  test 'can create respondent without name' do
    respondent = Respondent.new name: nil
    assert respondent.save!
  end
end
