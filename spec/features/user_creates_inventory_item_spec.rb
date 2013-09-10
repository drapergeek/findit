require 'spec_helper'

feature 'user creates inventory item' do
  scenario 'with basic information' do
    log_in

    visit new_item_path

    item = InventoryItemOnPage.new(
      name: 'Principal Computer',
      type: 'Laptop',
    )
    item.create!

    expect(item).to have_name('Principal Computer')
    expect(item).to be_of_type('Laptop')
  end

  scenario 'with all information' do
    log_in

    visit new_item_path

    item = InventoryItemOnPage.new.with_basic_information
    item.make = 'Dell'
    item.model = 'Latitude 210'
    item.processor = '2.4 GHz Intel Core 2 Duo'
    item.ram = '2048 mb'
    item.hard_drive = '250 gb'
    item.serial = '123456'
    item.unique_id = 'MY-UNIQUE-ID'
    item.create!

    expect(item).to have_make('Dell')
    expect(item).to have_model('Latitude 210')
    expect(item).to have_processor('2.4 GHz Intel Core 2 Duo')
    expect(item).to have_ram('2048 mb')
    expect(item).to have_hard_drive('250 gb')
    expect(item).to have_serial('123456')
    expect(item).to have_unique_id('MY-UNIQUE-ID')
  end

end
