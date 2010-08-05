require 'test_helper'

class PatronTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Patron.new.valid?
  end
  
  test "full name shows properly" do
    assert_equal "Tony Stark", patrons(:ironman).first_name + " " +patrons(:ironman).last_name
    assert_equal "Tony Stark", patrons(:ironman).name
  end
end
