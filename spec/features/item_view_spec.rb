require 'spec_helper'

feature 'user views item' do
  scenario ' and views the print label screen' do
    item = create(:item,
                  name: 'My Item',
                  ram: '1.0 GB',
                  processor: '2.0 Ghz Intel Core 2 Duo')

    log_in
    visit item_path(item)
    click_on 'Print Label'

    expect(page).to have_content item.name
    expect(page).to have_content "Ram: #{item.ram}"
    expect(page).to have_content "Processor: #{item.processor}"
  end
end
