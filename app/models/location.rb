class Location < ActiveRecord::Base
  attr_accessible :name, :info, :building_id
  validates_presence_of :building_id
  belongs_to :building
  has_many :items
  def full_name
    building.name + " - " + name
  end
end
