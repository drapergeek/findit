class Item < ActiveRecord::Base
  attr_accessible :name, :make, :model, :processor, :processor_rating, :ram, :hard_drive, :serial, :vt_tag, :purchased_at, :warranty_expires_at, :recieved_at, :os
  attr_accessible :type_of_item, :new_dns_names, :operating_system_id, :location_id
  has_many :ips
  has_many :installations
  has_many :softwares, :through=>:installations
  has_many :dns_names
  attr_accessor :new_dns_names
  before_save :create_dns_from_names
  before_save :convert_size_to_bytes
  belongs_to :operating_system
  belongs_to :location
  
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
  
  
  def convert_size_to_bytes
    unless self.ram.blank?
      if self.ram < 1048576
        self.ram = ram * 1048576
      end
    end
  
    unless self.hard_drive.blank?
      if self.hard_drive < 1073741824
        self.hard_drive =   hard_drive * 1073741824
      end
    end
  end
end
