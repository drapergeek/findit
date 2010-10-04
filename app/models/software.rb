class Software < ActiveRecord::Base
  attr_accessible :name, :license_key, :os, :number_of_licenses, :storage_location, :info, :operating_system_id
  has_many :installations, :dependent=>:destroy
  has_many :items, :through=>:installations
  belongs_to :operating_system
  default_scope :order=>"name"
end
