class TicketMailer < ActionMailer::Base
  default :from => APP_CONFIG['from_email']
  
  def send_ticket_to_admins(ticket)
      @ticket = ticket
      mail(:to => APP_CONFIG['emails_for_new_tickets_group'], :subject => "#{APP_CONFIG['ticket_subject']}#{ticket.id} ")
    end
  def send_ticket_to_submitter(ticket)
      @ticket = ticket
      mail(:to => "#{ticket.submitter.email}", :subject => "#{APP_CONFIG['ticket_subject']}#{ticket.id} ")
    end
end
