require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert build(:user).valid?
  end

  def test_reverse_name
    user = build(:user, :first_name => "Peter", :last_name => "Parker")
    assert_equal "Parker, Peter",user.reverse_name
  end
end
