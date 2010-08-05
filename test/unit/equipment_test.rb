require 'test_helper'

class EquipmentTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Equipment.new.valid?
  end
end
