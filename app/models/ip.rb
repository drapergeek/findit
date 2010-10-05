class Ip < ActiveRecord::Base
  attr_accessible :number, :info, :building_id
  validates_presence_of :building_id
  validates_presence_of :number
  belongs_to :item
  belongs_to :building
  scope :unassigned, :conditions=>['item_id IS NULL']
  default_scope :order=>['number ASC']
  
  def last_octet
    number.split(".")[3]
  end
  

end
