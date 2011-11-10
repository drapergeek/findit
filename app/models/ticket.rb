class Ticket < ActiveRecord::Base
  belongs_to :submitter, :class_name=>"User", :foreign_key=>"submitter_id"
  belongs_to :worker, :class_name=>"User", :foreign_key=>"worker_id"
  belongs_to :project
  belongs_to :area
  has_many :comments
  
  validates :submitter, :presence => true
  validates :title, :description, :status, :presence => true

  delegate :email, :to=>:submitter, :prefix=>true, :allow_nil=>true
  delegate :name, :to=>:area, :prefix=>true, :allow_nil=>true
  delegate :name, :to=>:project, :prefix=>true, :allow_nil=>true
  
  after_create :send_emails
  
  def send_emails
    if APP_CONFIG['send_new_tickets_to_group'] == "true"
       TicketMailer.send_ticket_to_admins(self).deliver
    end
    TicketMailer.send_ticket_to_submitter(self).deliver
  end
  
  def to_s
    title
  end
  #statuses - New, Open, Resolved, Stalled

  def self.create_from_email(from, subject, body)
    #first we need to see its a reply email and if so
    #pass it off to the comments
    if subject.scan(/Ticket-ID#\d+/).length >= 1 
      #this is a reply 
      id_number = subject.scan(/Ticket-ID#\d+/).first.split("#")[1]
      return false
    end
    
    #make sure we have a user
    if from
      from = User.find_or_create_by_email(from)
    end
    #parse for areas
    area = nil
    project = nil
    stop_looking = false
    #Look through all the area keywords and mark it with the first on you find
    Area.all.each do |a|
      break if stop_looking
      if a.keywords
        a.keywords.split(",").each do |k|
          if body.include?(k)
            stop_looking = true
            area = a
            break
          end
        end 
      end
    end

    #do the same thing for projects
    stop_looking = false
    Project.all.each do |p|
      break if stop_looking
      if p.keywords
        p.keywords.split(",").each do |k|
          if body.include?(k)
            stop_looking = true
            project = p
            break
          end
        end 
      end
    end
    Ticket.create!(:submitter=>from, :title=>subject, :description=>body, :status=>"New", :area=>area, :project=>project)
  end

end
