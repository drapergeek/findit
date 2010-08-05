class Location < ActiveRecord::Base
  attr_accessible :name, :info, :building_id
  validates_presence_of :building_id
  belongs_to :building
end
