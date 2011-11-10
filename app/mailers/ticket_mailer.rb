class TicketMailer < ActionMailer::Base
  default :from => APP_CONFIG['from_email']
  
  def on_ticket_creation(ticket)
      @ticket = ticket
      mail(:to => "#{ticket.submitter.full_name} <#{ticket.submitter.email}>", :subject => "#{APP_CONFIG['ticket_subject']}#{ticket.id} ")
    end
end
