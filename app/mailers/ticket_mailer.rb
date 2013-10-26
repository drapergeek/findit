class TicketMailer < ActionMailer::Base
  def admin_notification_of_new_ticket(emails, ticket, submitter)
      @ticket = ticket
      @submitter = submitter
      emails = emails.join(",")

      mail(to: emails,
           from: from_address_for_ticket(@ticket),
           subject: "New Ticket from #{@submitter.name}",
          )
  end

  def submission_confirmation(email, ticket)
    @ticket = ticket

    mail(to: email,
         from: from_address_for_ticket(@ticket),
         subject: "Ticket Successfully Submitted",
        )
  end

  def send_reply_comment(comment, emails)
    @comment = comment
    @ticket = comment.ticket
    email_string = emails.join(',')
    subject = "Reply from Ticket-#{@ticket.id}"

    mail(to: email_string,
         from: from_address_for_ticket(@ticket),
         subject: subject)
  end

  def send_ticket_resolved_notification(ticket)
    @ticket = ticket
    @user = ticket.submitter
    if @user.email
      mail(:to => @user.email,
           :from => 'temp@example.com',
           :subject => "Ticket resolved")
    end
  end
  private

  def from_address_for_ticket(ticket)
    "ticket-#{ticket.id}@#{ENV['EMAIL_HOST']}"
  end
end
