class EmailProcessor
  NEW_TICKET_TOKEN = 'help'

  def self.process(email)
    new(email).process
  end

  def initialize(email)
    @email = email
    @name = email.from[:name]
    @email_address = email.from[:email]
  end

  def process
    if new_ticket?
      TicketCreator.create_from_email(user, email.subject, email.body)
    else
      if has_associated_ticket?
        TicketReplyHandler.process(user, associated_ticket, email.body)
      end
    end
  end

  def user
    @user ||= User.find_or_create_with_name_and_email(name, email_address)
  end

  private
  attr_accessor :email, :name, :email_address

  def to_token
    email.to.first[:token]
  end

  def new_ticket?
    to_token == NEW_TICKET_TOKEN
  end

  def has_associated_ticket?
    associated_ticket.present?
  end

  def associated_ticket
    ticket_id = to_token.split("-").last
    ticket = Ticket.find_by_id(ticket_id)
  end
end
