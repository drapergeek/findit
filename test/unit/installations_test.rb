require 'test_helper'

class InstallationsTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Installations.new.valid?
  end
end
