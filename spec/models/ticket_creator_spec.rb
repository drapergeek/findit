require 'spec_helper'

describe TicketCreator do
  describe '.create_from_email' do
    it 'attaches the ticket to the given user' do
      user = create(:user)
      TicketCreator.create_from_email(user, '', '')

      created_ticket_user = Ticket.last.submitter

      expect(created_ticket_user).to eq(user)
    end

    it 'will send an email to the creator' do
      user = create(:user)
      ticket = TicketCreator.create_from_email(user, '', '')

      email = open_email(user.email)
      expect(email.to).to include(user.email)
      expect(email.subject).to eq('Ticket Successfully Submitted')
      expect(email.from.first).to include("ticket-#{ticket.id}")
    end

    it 'will send emails to all admins' do
      admin = create(:user, can_login: true)
      submitter = create(:user, can_login: false)

      ticket = TicketCreator.create_from_email(submitter, '', '')

      email = open_email(admin.email)
      expect(email.to).to eq([admin.email])
      expect(email.subject).to eq("New Ticket from #{submitter.name}")
      expect(email.from.first).to include("ticket-#{ticket.id}")
    end
  end
end
