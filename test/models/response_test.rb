require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  setup do
    @respondent = respondents(:one)

    complete_answer = answers(:one)
    incomplete_answer = answers(:one_incomplete)

    respondent_attributes = {
      name: @respondent.name
    }

    @invalid_params = {
      answers_attributes: {
        "0": {
          question_id: incomplete_answer.question_id,
          answer: incomplete_answer.answer
        }
      },
      respondent_attributes: respondent_attributes
    }

    @valid_params = {
      answers_attributes: {
        "0": {
          question_id: complete_answer.question_id,
          answer: complete_answer.answer
        }
      },
      respondent_attributes: respondent_attributes
    }
  end

  test 'can create response' do
    response = Response.new @valid_params
    assert response.save!
  end

  test 'can\'t create response if missing answers' do
    response = Response.new @invalid_params

    begin
      response.save!
      assert false
    rescue ActiveRecord::RecordInvalid
      assert true
    end
  end
end
