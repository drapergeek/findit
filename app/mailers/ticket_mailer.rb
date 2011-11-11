class TicketMailer < ActionMailer::Base
  default :from => APP_CONFIG['from_email']
  
  def send_ticket_to_admins(ticket)
      @ticket = ticket
      mail(:to => APP_CONFIG['emails_for_new_tickets_group'], :subject => "#{APP_CONFIG['ticket_subject']}#{ticket.id} New Ticket")
    end
    
  def send_ticket_to_submitter(ticket)
      @ticket = ticket
      mail(:to => "#{ticket.submitter.email}", :subject => "#{APP_CONFIG['ticket_subject']}#{ticket.id} Successfully Submitted")
    end
    
    def send_reply_comment(comment)
        @comment = comment
        @ticket = @comment.ticket
        mail(:to => "#{@ticket.submitter.email}", :subject => "#{APP_CONFIG['ticket_subject']}#{@ticket.id} Reply from Ticket")
      end
end
