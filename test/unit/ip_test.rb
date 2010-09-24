require 'test_helper'

class IpTest < ActiveSupport::TestCase
  
  
  test "valid ip" do
    ip = Ip.new(:number=>"128.173.129.1", :building_id=>buildings(:mccomas).id)
    assert ip.valid?
  end
  
  
end
