class Item < ActiveRecord::Base
  attr_accessible :name, :make, :model, :processor, :processor_rating, :ram, :hard_drive, :serial, :vt_tag, :purchased_at, :warranty_expires_at, :recieved_at, :os, :type, :new_dns_names
  has_many :ips
  has_many :installations
  has_many :softwares, :through=>:installations
  has_many :dns_names
  attr_accessor :new_dns_names
  before_save :create_dns_from_names
  
  def create_dns_from_names
    unless new_dns_names.blank?
      if new_dns_names.include? ","
        names = new_dns_names.split(",")
        for name in names do
            dns_names.build(:name=>name)
        end
      else
          dns_names.build(:name=>new_dns_names)
      end
    end
  end
end
