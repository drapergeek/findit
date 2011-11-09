class Ticket < ActiveRecord::Base
  belongs_to :submitter, :class_name=>"User", :foreign_key=>"submitter_id"
  belongs_to :worker, :class_name=>"User", :foreign_key=>"worker_id"
  belongs_to :project
  belongs_to :area
  has_many :comments
  
  validates :submitter, :presence => true
  validates :title, :description, :status, :presence => true
  
  def to_s
    title
  end
end
