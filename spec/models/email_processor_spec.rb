require 'spec_helper'

describe EmailProcessor do
  describe 'when the to is the new ticket from' do
    it 'will delegate to the ticket creator' do
      allow(TicketCreator).to receive(:create_from_email).and_return(true)
      email = create(:email,
                     subject: 'Please help me!',
                     body: 'I have problems')

      EmailProcessor.process(email)

      expect(TicketCreator).to have_received(:create_from_email).with(
        anything,
        'Please help me!',
        'I have problems')
    end
  end

  describe 'when the to is based on a ticket' do
    it 'will delegate to the TicketReplyHandler' do
      ticket = create(:ticket)
      allow(TicketReplyHandler).to receive(:process).and_return(true)

      email = create(:email,
                     to: [{token: "ticket-#{ticket.id}"}],
                     body: 'that sounds fine',
                    )

      EmailProcessor.process(email)

      expect(TicketReplyHandler).to have_received(:process).with(
        User.last,
        ticket,
        'that sounds fine',
      )
    end
  end

  describe '#user' do
    it 'delegates to the user method to find or create' do
      allow(User).to receive(:find_or_create_with_name_and_email)
      from = { name: 'Peter Parker', email: 'spiderman@example.com'}
      email = create(:email, from: from)

      EmailProcessor.new(email).user

      expect(User).to have_received(:find_or_create_with_name_and_email).with(
        'Peter Parker',
        'spiderman@example.com',
      )
    end
  end
end
