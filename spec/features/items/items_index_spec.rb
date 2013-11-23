require 'spec_helper'

feature 'items index', js: true do
  scenario 'user sorts by name' do
    first_item = create(:item, name: 'An iPad')
    second_item = create(:item, name: 'Book')

    log_in
    visit items_path
    expect(page).to have_first_item_named(first_item.name)
    expect(page).to have_last_item_named(second_item.name)


    click_on "Name"
    expect(page).to have_first_item_named(second_item.name)
    expect(page).to have_last_item_named(first_item.name)
  end

  def have_first_item_named(item_name)
    have_selector("tbody tr.item_row:first-of-type", text: item_name)
  end

  def have_last_item_named(item_name)
    have_selector("tbody tr.item_row:last-of-type", text: item_name)
  end
end
