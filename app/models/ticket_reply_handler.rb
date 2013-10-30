class TicketReplyHandler
  def self.process(user, ticket, body)
    new(user, ticket, body).process
  end

  def initialize(user, ticket, body)
    @user = user
    @ticket = ticket
    @body = body
  end

  def process
    create_comment
    reopen_ticket_if_closed
    send_emails
  end

  def users_for_reply_email
    all_users_on_ticket.delete(user)
    all_users_on_ticket
  end

  private
  attr_reader :user, :ticket, :body, :comment

  def send_emails
    TicketMailer.send_reply_comment(comment, user_emails).deliver
  end

  def user_emails
    all_users_on_ticket.compact.map(&:email)
  end

  def all_users_on_ticket
    @all_users_on_ticket ||= find_users_on_ticket
  end

  def find_users_on_ticket
    all_users_on_ticket = []

    all_users_on_ticket << ticket.submitter
    all_users_on_ticket << ticket.worker
    all_users_on_ticket += ticket.comments.map do |comment|
      comment.user
    end

    all_users_on_ticket.uniq
  end

  def create_comment
    @comment = ticket.comments.create(user: user, body: body)
  end

  def reopen_ticket_if_closed
    if ticket.closed?
      ticket.reopen
    end
  end
end
