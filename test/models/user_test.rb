require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test 'can create user' do
    assert_not_nil @user
  end
end
