require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  test 'valid answer' do
    answer = Answer.new answer: 'yes', question_id: 1
    assert answer.valid?
  end

  test 'can\'t save answer if blank' do
    answer = Answer.new answer: nil, question_id: 1

    assert_raise ActiveRecord::RecordInvalid do
      answer.save!
    end
  end
end
