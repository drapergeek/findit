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
    
  def send_reply_comment(comment, params={})
    @comment = comment
    @ticket = @comment.ticket
    to = ""
    if params[:send_to_submitter]
      to += @ticket.submitter_email.to_s
    end
    if params[:send_to_worker]
      to += @ticket.worker_email.to_s
    end
    mail(:to => to, :subject => "#{APP_CONFIG['ticket_subject']}#{@ticket.id} Reply from Ticket")
  end
  
  def send_worker_changed_notification(ticket)
    @ticket = ticket
    @user = ticket.worker
    if @user.email
      mail(:to => @user.email, :subject => "#{APP_CONFIG['worker_notify_subject']}")
    end    
  end
  
  def send_ticket_resolved_notification(ticket)
    @ticket = ticket
    @user = ticket.submitter
    if @user.email
      mail(:to => @user.email, :subject => "#{APP_CONFIG['resolved_notify_subject']}")
    end    
  end
end
