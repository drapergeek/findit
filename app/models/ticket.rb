class Ticket < ActiveRecord::Base
  belongs_to :submitter, :class_name=>"User", :foreign_key=>"submitter_id"
  belongs_to :worker, :class_name=>"User", :foreign_key=>"worker_id"
  belongs_to :project
  belongs_to :area
  
  validates :submitter, :presence => true
  validates :title, :description, :status, :presence => true

  delegate :email, :to=>:submitter, :prefix=>true
  
  #statuses - New, Open, Resolved, Stalled

  def self.create_from_email(from, subject, body)
    #make sure we have a user
    if from
      from = User.find_or_create_by_email(from)
    end
    Ticket.create!(:submitter=>from, :title=>subject, :description=>body, :status=>"New")
  end
  
end
