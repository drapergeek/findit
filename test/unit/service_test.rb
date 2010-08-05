require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Service.new.valid?
  end
  
  test "current should only show current services" do 
    services = Service.current
    assert_equal services.count, 1
  end
end
