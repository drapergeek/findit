require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert build(:location).valid?
  end
end
