class TicketCreator
  def self.create_from_email(from, subject, body)
    new(from, subject, body).from_email
  end

  def initialize(user, subject, body)
    @user = user
    @subject = subject
    @body = body
  end

  def from_email
    create_ticket
    send_confirmation_to_submitter
    send_notification_to_admins
    ticket
  end

  private
  attr_reader :name, :email, :user, :ticket

  def create_ticket
    @ticket = Ticket.create!(submitter_id: user.id,
                             title: subject,
                             description: body,
                             status: 'New')
  end

  def send_confirmation_to_submitter
    TicketMailer.submission_confirmation(user.email, ticket).deliver
  end

  def send_notification_to_admins
    TicketMailer.admin_notification_of_new_ticket(admin_emails, ticket, user).deliver
  end

  def admin_emails
    admin_emails = User.workers.map(&:email)
  end

  def subject
    if @subject.empty?
      @subject = 'Emailed Ticket'
    else
      @subject
    end
  end

  def body
    if @body.empty?
      @body = 'Blank Body'
    else
      @body
    end
  end
end
