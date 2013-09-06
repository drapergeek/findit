require 'spec_helper'

feature 'admin submit tickets' do
  scenario 'with basic information' do
    log_in
    submitter = create(:user, first_name: 'Sally', last_name: 'Smith')

    visit new_ticket_path
    fill_in 'Title', with: 'broken monitor'
    fill_in 'Description', with: 'The monitor in room 210 is broken'
    select 'Sally Smith', from: 'Submitter'
    select 'Open', from: 'Status'
    click_button 'Create Ticket'

    expect(page).to have_content 'broken monitor - Open'
    expect(page).to have_content 'The monitor in room 210 is broken'
    expect(page).to have_content 'Submitter: Sally Smith'
  end

  def log_in(user = create(:user))
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end
