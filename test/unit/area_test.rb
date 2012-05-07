require 'test_helper'

class AreaTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert build(:area).valid?
  end
  
  test "Test to make sure an area has a name" do
    area = build(:area, :name => '')
    assert !area.valid?, 'The area should be valid because it doesnt  have a name'
    area.name = 'Demo'
    assert area.valid?, 'the area should be valid now that it has a name'
  end
  
  test "Test to make sure keywords are not required" do
    area = build(:area)
    assert area.valid?, 'should be true because it is the default area and keywords is not required'
    area.keywords = 'hello world, o no, hey'
    assert area.valid?, 'should be true even after keywords are valid'
  end
  
  test "Make sure the keywords are stored properly" do
    keywords = 'hello world, list2, number 3'
    area = build(:area, :keywords => keywords)
    assert area.valid?, 'This should be true as it is a standard area'
    assert_equal area.keywords, keywords, 'This should be equal or the keywords are not stored properly'
  end
  
end
