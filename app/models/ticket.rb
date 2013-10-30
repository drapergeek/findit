class Ticket < ActiveRecord::Base
  STATUSES = ["New", "Open", "Stalled", "Resolved"]

  belongs_to :submitter, class_name: "User"
  belongs_to :worker, :class_name=>"User", :foreign_key=>"worker_id"
  belongs_to :project
  belongs_to :area
  has_many :comments

  validates :submitter, :presence => true
  validates :title, :description, :status, :presence => true

  delegate :email, :to=>:submitter, :prefix=>true, :allow_nil=>true
  delegate :name, to: :submitter, :prefix=>true, :allow_nil=>true
  delegate :email, :to=>:worker, :prefix=>true, :allow_nil=>true
  delegate :name, :to=>:area, :prefix=>true, :allow_nil=>true
  delegate :name, :to=>:project, :prefix=>true, :allow_nil=>true

  delegate :name, :to=>:area, :prefix=>true, :allow_nil=>true

  after_update :notify_resolved
  before_destroy :cancel_delete

  def self.unresolved
    where("status != ?", "Resolved")
  end

  def self.for_area(area)
    where(area: area)
  end

  def closed?
    status == 'Resolved'
  end

  def reopen
    update_attribute(:status, 'Open')
  end

  def cancel_delete
    false
  end

  def to_s
    title
  end

  private

  def notify_resolved
    if self.status_changed?
      if self.status == "Resolved"
        TicketMailer.send_ticket_resolved_notification(self).deliver
      end
    end
  end
end
