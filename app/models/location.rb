class Location < ActiveRecord::Base
  validates_presence_of :building_id
  belongs_to :building
  has_many :items, :dependent=>:nullify

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
