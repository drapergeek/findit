class Location < ActiveRecord::Base
  attr_accessible :name, :info, :building_id
  validates_presence_of :building_id
  belongs_to :building
  has_many :items
  def full_name
    building.name + " - " + name
  end
  
  def short_location
    building.name[0,1].upcase + " - " + name
  end
end
