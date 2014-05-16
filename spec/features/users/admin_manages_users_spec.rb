require 'spec_helper'

feature 'admin manages users' do
  scenario 'creates a new user who cannot log in' do
    log_in
    visit users_path
    click_on 'Add New User'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'johndoe@example.com'
    click_on 'Create User'

    expect(page).to have_user('John Doe')
  end

  def have_user(name)
    have_css("[data-role='user-name']", text: name)
  end
end
