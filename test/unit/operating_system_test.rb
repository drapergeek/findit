require 'test_helper'

class OperatingSystemTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert OperatingSystem.new.valid?
  end
end
