class Ip < ActiveRecord::Base
  attr_accessible :number, :info, :building_id
  validates_presence_of :building_id
  belongs_to :item
  belongs_to :building
  named_scope :unassigned, :conditions=>['item_id IS NULL']
end
