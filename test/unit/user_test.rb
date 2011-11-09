require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert User.new.valid?
  end

  def test_reverse_name
    user = Factory.build(:user)
    assert_equal "Parker, Peter",user.reverse_name  
  end

  test "find_or_create_by_email will create" do
    email = "storm@xmen.com"
    user = User.find_or_create_by_email(email)
    assert_equal email, user.email
    assert_equal "storm", user.login
    assert_equal "No", user.first_name
    assert_equal "Name", user.last_name
  end
  test "find_or_create_by_email will find an existing email" do
    user = Factory.create(:user) 
    found_user = User.find_or_create_by_email(user.email)
    assert_equal user.id, found_user.id
    assert_equal user.first_name, found_user.first_name
  end

end
