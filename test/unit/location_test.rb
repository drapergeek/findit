require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Location.new(:name=>"88A", :building_id=>buildings(:mccomas).id)
  end
end
