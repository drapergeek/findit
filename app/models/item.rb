class Item < ActiveRecord::Base
  attr_accessible :name, :make, :model, :processor, :processor_rating, :ram, :hard_drive, :serial, :vt_tag, :purchased_at, :warranty_expires_at, :recieved_at, :os, :type
  has_many :ips
  has_many :installations
  has_many :softwares, :through=>:installations
end
