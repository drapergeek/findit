class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user

  validates :ticket, :user, :presence => true
  validates :body, :presence => true

  delegate :name, :to=>:user, :prefix=>true, :allow_nil=>true

  after_save :update_ticket_status

  def ticket_status
    self.ticket.status unless ticket.nil?
  end

  def ticket_status=(status)
    @status = status
  end

  private

  def update_ticket_status
    if self.ticket && @status && self.ticket.status != @status
      self.ticket.update_attributes(:status=>@status)
    end
  end
end
