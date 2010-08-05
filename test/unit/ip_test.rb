require 'test_helper'

class IpTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Ip.new.valid?
  end
end
