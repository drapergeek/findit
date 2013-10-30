require 'spec_helper'

describe TicketReplyHandler do
  describe 'process' do
    it 'will create a new comment with the body' do
      user = create(:user)
      ticket = create(:ticket)

      TicketReplyHandler.process(user, ticket, 'This is my reply')
      new_comment = ticket.comments.last

      expect(new_comment.user).to eq(user)
      expect(new_comment.ticket).to eq(ticket)
    end

    it 'will reopen the ticket if it was closed' do
      user = create(:user)
      ticket = create(:ticket, status: 'Resolved')

      TicketReplyHandler.process(user, ticket, 'This is stil broken')
      new_comment = ticket.comments.last

      expect(ticket).not_to be_closed
    end
  end

  describe '.users_for_reply_email' do
    it 'sends an email to everyone on the ticket except the given user' do
      working_user = create(:user)
      submitting_user = create(:user)
      comment_user = create(:user)
      ticket = create(:ticket, worker: working_user, submitter: submitting_user)

      handler = TicketReplyHandler.new(comment_user, ticket, 'This is stil broken')
      handler.process
      expect(handler.users_for_reply_email).to eq([submitting_user, working_user])
    end
  end
end
