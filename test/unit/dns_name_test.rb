require 'test_helper'

class DnsNameTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert DnsName.new.valid?
  end
end
