require 'spec_helper'

describe Comment do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:ticket) }
  it { should belong_to(:user) }
  it { should belong_to(:ticket) }

  it 'can update ticket status on save' do
    ticket = create(:ticket)
    expect(ticket.status).to eq('Open')
    comment = build(:comment, ticket: ticket)
    comment.ticket_status = "Resolved"
    comment.save
    expect(ticket.status).to eq("Resolved")
  end
end
