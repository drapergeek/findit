class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  
  validates :ticket, :user, :presence => true
  validates :body, :presence => true
  
  delegate :name, :to=>:user, :prefix=>true, :allow_nil=>true
  after_create :send_emails
  
  def send_emails
    if self.reply
      if self.user == self.ticket.worker
       TicketMailer.send_reply_comment(self, :send_to_submitter=>true).deliver
      elsif self.user == self.ticket.submitter
       TicketMailer.send_reply_comment(self, :send_to_worker=>true).deliver
      else
       TicketMailer.send_reply_comment(self, :send_to_worker=>true, :send_to_submitter=>true).deliver
      end
    end
  end

  def self.create_from_email(ticket_id, from, subject, body)
    #get the user first
    user = User.find_or_create_by_email(from)
    #get the ticket
    ticket = Ticket.find(ticket_id)
    if ticket.status == "Resolved" 
      ticket.status = "Open"
      body += "Status changed to Open on a new comment email \n" 
      ticket.save
    end
    ticket.comments.create!(:user=>user, :subject=>subject, :body=>body, :reply=>true) 
  end
  
  def ticket_status
    self.ticket.status  #add delegate
  end
  
  def ticket_status=(status)
    self.ticket.status = status;
  end



end
