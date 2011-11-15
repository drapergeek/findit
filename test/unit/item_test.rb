require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert new_valid_item.valid?
  end
  
  def test_valid_item_factory
   assert Factory.build(:item).valid? 
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

  test "surplus marks the time of surplus" do
    item = Factory.create(:item)
    assert_nil item.surplused_at 
    item.mark_as_surplused
    assert_not_nil item.surplused_at
  end

  test "surplus removes all software from an item" do
    item = Factory.create(:item)    
    Installation.create!(:item_id=>item.id, :software_id=>Factory.create(:software).id)
    assert_equal 1,item.softwares.count
    item.mark_as_surplused
    assert_equal 0,item.softwares.count
  end

  test "surplus writes the software installed to the info" do
    item = Factory.create(:item)    
    software = Factory.create(:software)
    software2 = Factory.create(:software)
    Installation.create!(:item_id=>item.id, :software_id=>software.id)
    Installation.create!(:item_id=>item.id, :software_id=>software2.id)
    assert_equal 2,item.softwares.count
    item.mark_as_surplused
    assert item.info.include?("Software #{software.name} was installed when surplused.")
    assert item.info.include?("Software #{software2.name} was installed when surplused.")
  end

  test "surplus removes the user and adds the line to the info about the user" do
    user = Factory.create(:user)
    item = Factory.create(:item, :user=>user)
    assert_equal item.user, user
    item.mark_as_surplused
    assert_nil item.user
    assert item.info.include?("The user was #{user.full_info} when surplused.")
  end


  test "surplus removes the location and the building and adds it to the info" do
    location = Factory.create(:location)
    item = Factory.create(:item, :location=>location)
    assert_equal item.location, location
    item.mark_as_surplused
    assert_nil item.location
    assert item.info.include?("The item was located at #{location.full_name} when surplused")
  end

  test "surplus removes the ips and puts them in the info" do
    item = Factory.create(:item)
    ip1 = Factory.create(:ip)
    ip2 = Factory.create(:ip)
    item.ips << ip1
    item.ips << ip2
    assert_equal 2,item.ips.count 
    item.mark_as_surplused
    assert_equal 0, item.ips.count
    assert item.info.include?("The IP #{ip1.number} was assigned when surplused.")
    assert item.info.include?("The IP #{ip2.number} was assigned when surplused.")
  end

  test "surplus removes the operating system and puts it in the info" do
    os = Factory.create(:operating_system)
    item = Factory.create(:item, :operating_system=>os)
    assert_equal item.operating_system, os
    item.mark_as_surplused
    assert_nil item.operating_system
    assert item.info.include?("The OS #{os.name} was installed when surplused.")
  end 

  test "surplus sets the in use to false" do
    item = Factory.create(:item)
    assert item.in_use != false
    item.mark_as_surplused
    assert item.in_use == false
  end

  test "qrl_code_url gives a url that includes certain information" do
    item = Factory.create(:item) 
    assert item.qr_url.include?("http://www.sparqcode.com")
    assert item.qr_url.include?("https://findit.recsports.vt.edu/items/#{item.name}")
    assert item.qr_url.include?(item.name.upcase)
  end
    
  def new_valid_item
    return Item.new(:type_of_item=>"Desktop")
  end
end
