require 'spec_helper'

feature 'items index', js: true do
  scenario 'shows the item names' do
    first_item = create(:item, name: 'An iPad')
    second_item = create(:item, name: 'Book')

    log_in
    visit items_path
    expect(page).to have_item_named(first_item.name)
    expect(page).to have_item_named(second_item.name)
  end

  def have_item_named(item_name)
    have_selector(".ember-table-cell", text: item_name)
  end
end
