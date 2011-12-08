require 'spec_helper'

describe "TicketUpdates" do
  describe "ticket change" do
    it "allows the user to update the ticket status in a comment" do
      ticket = Factory.create(:ticket)
      visit ticket_path(ticket)
      fill_in "comment_body", :with=>"This is my comment"
      select "Resolved", :from=>"comment_ticket_status"
      click_button "Create Comment"
      current_path.should eq(ticket_path(ticket))
      save_and_open_page
      page.should have_content("Status: Resolved")
    end
  end
end
