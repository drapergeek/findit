class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  
  validates :ticket, :user, :presence => true
  validates :body, :presence => true


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
    ticket.comments.create!(:user=>user, :subject=>subject, :body=>body) 
  end



end
