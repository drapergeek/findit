require 'test_helper'

class SoftwareTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert build(:software)
  end
end
