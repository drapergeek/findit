class Software < ActiveRecord::Base
  attr_accessible :name, :license_key, :os, :number_of_licenses, :storage_location, :info
  has_many :installations
  has_many :items, :through=>:installations
end
