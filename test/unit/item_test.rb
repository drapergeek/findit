require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def test_valid_item_factory
    assert build(:item).valid?
  end

  test "by type scope works" do
    printer = create(:item, :type_of_item => "Printer")
    printers = Item.by_type("Printer")
    assert printers.include?(printer)
    assert_equal printers.count, 1
  end

  test "surplus marks the time of surplus" do
    item = create(:item)
    assert_nil item.surplused_at
    item.mark_as_surplused
    assert_not_nil item.surplused_at
  end

  test "surplus removes all software from an item" do
    item = create(:item)
    Installation.create!(:item_id=>item.id, :software_id=>create(:software).id)
    assert_equal 1,item.softwares.count
    item.mark_as_surplused
    assert_equal 0,item.softwares.count
  end

  test "surplus writes the software installed to the info" do
    item = create(:item)    
    software = create(:software)
    software2 = create(:software)
    Installation.create!(:item_id=>item.id, :software_id=>software.id)
    Installation.create!(:item_id=>item.id, :software_id=>software2.id)
    assert_equal 2,item.softwares.count
    item.mark_as_surplused
    assert item.info.include?("Software #{software.name} was installed when surplused.")
    assert item.info.include?("Software #{software2.name} was installed when surplused.")
  end

  test "surplus removes the user and adds the line to the info about the user" do
    user = create(:user)
    item = create(:item, :user=>user)
    assert_equal item.user, user
    item.mark_as_surplused
    assert_nil item.user
    assert item.info.include?("The user was #{user.full_info} when surplused.")
  end


  test "surplus removes the location and the building and adds it to the info" do
    location = create(:location)
    item = create(:item, :location=>location)
    assert_equal item.location, location
    item.mark_as_surplused
    assert_nil item.location
    assert item.info.include?("The item was located at #{location.full_name} when surplused")
  end

  test "surplus removes the ips and puts them in the info" do
    item = create(:item)
    ip1 = create(:ip)
    ip2 = create(:ip)
    item.ips << ip1
    item.ips << ip2
    assert_equal 2,item.ips.count 
    item.mark_as_surplused
    assert_equal 0, item.ips.count
    assert item.info.include?("The IP #{ip1.number} was assigned when surplused.")
    assert item.info.include?("The IP #{ip2.number} was assigned when surplused.")
  end

  test "surplus removes the operating system and puts it in the info" do
    os = create(:operating_system)
    item = create(:item, :operating_system=>os)
    assert_equal item.operating_system, os
    item.mark_as_surplused
    assert_nil item.operating_system
    assert item.info.include?("The OS #{os.name} was installed when surplused.")
  end 

  test "surplus sets the in use to false" do
    item = create(:item)
    assert item.in_use != false
    item.mark_as_surplused
    assert item.in_use == false
  end

  def new_valid_item
    return Item.new(:type_of_item=>"Desktop")
  end
end
