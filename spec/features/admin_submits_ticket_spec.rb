require 'spec_helper'

feature 'admin submit tickets' do
  scenario 'with basic information' do
    log_in
    submitter = create(:user, first_name: 'Sally', last_name: 'Smith')

    visit new_ticket_path

    ticket = TicketOnPage.new(
      title: 'broken monitor',
      description: 'The monitor in room 210 is broken',
      submitter: 'Sally Smith',
      status: 'Open',
    )
    ticket.submit!

    expect(ticket).to have_title 'broken monitor'
    expect(ticket).to have_description 'The monitor in room 210 is broken'
    expect(ticket).to have_status 'Open'
    expect(ticket).to have_submitter 'Sally Smith'
  end

  scenario 'and adds a comment' do
    log_in
    visit new_ticket_path

    ticket = TicketOnPage.new.with_basic_information
    ticket.add_comment 'I will look at this tomorrow'

    expect(ticket).to have_comment 'I will look at this tomorrow'
  end

  scenario 'and closes the ticket with a comment' do
    log_in
    visit new_ticket_path

    ticket = TicketOnPage.new.with_basic_information
    ticket.add_comment 'I replaced the hard drive', status: 'Resolved'

    expect(ticket).to have_comment 'I replaced the hard drive'
    expect(ticket).to be_closed
  end
end
