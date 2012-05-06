class Location < ActiveRecord::Base
  attr_accessible :name, :info, :building_id
  validates_presence_of :building_id
  belongs_to :building
  has_many :items, :dependent=>:nullify
  default_scope :include=>:building, :order=>["buildings.name, locations.name"]

  def full_name
    if building
      building.name + " - " + name
    else
      name
    end
  end

  def short_location
    building.name[0,1].upcase + " - " + name
  end

  def to_s
    name
  end
end
