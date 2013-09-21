require 'spec_helper'

feature 'admin views tickets' do
  scenario 'only unresolved tickets' do
    unresolved_tickets = create_list(:ticket, 2, :unresolved)
    resolved_ticket = create(:ticket, :resolved)
    log_in

    visit tickets_path
    click_on 'Tickets'

    unresolved_tickets.each do |ticket|
      page.should have_ticket(ticket)
    end

    page.should_not have_ticket(resolved_ticket)
  end

  RSpec::Matchers.define :have_ticket do |ticket|
    match do |page|
      page.has_content?(ticket.title) &&
        page.has_content?(ticket.submitter)
    end
  end
end
