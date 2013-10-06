require 'spec_helper'

feature 'user manages buildings' do
  scenario 'adds a new building' do
    log_in
    visit buildings_path
    fill_in 'Name', with: 'Building 421'
    fill_in 'Info', with: '132 Main St'
    click_on 'Create Building'
    expect(page).to have_content 'Building 421'
    expect(page).to have_content '132 Main St'
  end

  scenario 'edits existing building' do
    create(:building, name: 'Building 15')
    log_in

    visit buildings_path
    click_on 'Edit'
    fill_in 'Name', with: 'Building 51'
    click_on 'Update Building'

    expect(page).to have_content 'Building 51'
  end

  scenario 'deletes existing building' do
    create(:building, name: 'Homebase')
    log_in

    visit buildings_path
    expect(page).to have_content('Homebase')
    click_on 'Destroy'

    expect(page).not_to have_content('Homebase')
  end
end
