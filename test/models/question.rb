require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  setup do
    @question = questions(:one)
  end

  test 'can create question' do
    assert_not_nil @question
  end
end
