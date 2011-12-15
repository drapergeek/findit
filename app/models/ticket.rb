class Ticket < ActiveRecord::Base
  belongs_to :submitter, :class_name=>"User", :foreign_key=>"submitter_id"
  belongs_to :worker, :class_name=>"User", :foreign_key=>"worker_id"
  belongs_to :project
  belongs_to :area
  has_many :comments
  
  validates :submitter, :presence => true
  validates :title, :description, :status, :presence => true

  delegate :email, :to=>:submitter, :prefix=>true, :allow_nil=>true
  delegate :email, :to=>:worker, :prefix=>true, :allow_nil=>true
  delegate :name, :to=>:area, :prefix=>true, :allow_nil=>true
  delegate :name, :to=>:project, :prefix=>true, :allow_nil=>true
  
  scope :for_user, lambda{|user_id| where("worker_id = ?", "#{user_id}")}
  scope :for_area, lambda{|area_id| where("area_id = ?", "#{area_id}")}
  scope :for_project, lambda{|project_id| where("project_id = ?", "#{project_id}")}
  scope :unassigned, where(:worker_id => nil)
  scope :open, where(:status=>"Open")
  scope :resolved, where(:status=>"Resolved")
  scope :unresolved, where("status != ?", "Resolved")
  
  delegate :name, :to=>:area, :prefix=>true, :allow_nil=>true
  
  after_create :send_emails
  after_update :notify_workers, :notify_resolved
  
  def send_emails
    if APP_CONFIG['send_new_tickets_to_group']
       TicketMailer.send_ticket_to_admins(self).deliver
    end
    @emails = APP_CONFIG['emails_for_new_tickets_group']
    if self.submitter && self.submitter_email && @emails.include?(self.submitter_email)
        TicketMailer.send_ticket_to_submitter(self).deliver
    end
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
      return Comment.create_from_email(id_number, from, subject, body)
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
  
  private
  
  def notify_workers
    if self.worker_id_changed?
      TicketMailer.send_worker_changed_notification(self).deliver
    end
  end
  
  def notify_resolved
    if self.status_changed?
      if self.status == "Resolved"
        TicketMailer.send_ticket_resolved_notification(self).deliver
      end
    end
  end
  

end
