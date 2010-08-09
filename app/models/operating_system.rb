class OperatingSystem < ActiveRecord::Base
  attr_accessible :name, :info
  has_many :items
  has_many :softwares
end
