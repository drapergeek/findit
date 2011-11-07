require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert User.new.valid?
  end

  def test_reverse_name
    user = Factory.build(:user)
    assert_equal "Parker, Peter",user.reverse_name  
  end

end
