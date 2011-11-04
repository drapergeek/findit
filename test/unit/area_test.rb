require 'test_helper'

class AreaTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Factory.build(:area).valid?
  end
  
  test "Test to make sure an area has a name" do
    area = Factory.build(:area, :name => '')
    assert !area.valid?, 'The area should be valid because it doesnt  have a name'
    area.name = 'Demo'
    assert area.valid?, 'the area should be valid now that it has a name'
  end
  
end
