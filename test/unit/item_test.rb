require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Item.new.valid?
  end
  
  
  test "by type scope works" do
    printers = Item.by_type("Printer")
    assert printers.include?(items(:printer))
    assert_equal printers.count, 1
    printer = new_valid_item
    printer.type_of_item = "Printer"
    printer.save
    printers = Item.by_type("Printer")
    assert printers.include?(printer)
    assert_equal printers.count, 2
  end

  
  def new_valid_item
    return Item.new
  end
end
