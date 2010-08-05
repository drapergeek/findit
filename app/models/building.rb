class Building < ActiveRecord::Base
  attr_accessible :name, :info
  has_many :ips
  has_many :locations
end
