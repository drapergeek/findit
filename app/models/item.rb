class Item < ActiveRecord::Base
  attr_accessible :name, :make, :model, :processor, :processor_rating, :ram, :hard_drive, :serial, :vt_tag, :purchased_at, :warranty_expires_at, :recieved_at, :os
  attr_accessible :type_of_item, :new_dns_names, :operating_system_id, :location_id, :user_id, :info
  has_many :ips
  has_many :installations
  has_many :softwares, :through=>:installations
  has_many :dns_names
  named_scope :has_ip, :include=> :ips, :conditions=>["ips.id in (SELECT id from ips)"]
  attr_accessor :new_dns_names
  before_save :create_dns_from_names
  before_save :convert_size_to_bytes
  belongs_to :operating_system
  belongs_to :location
  belongs_to :user
  
  
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
  
  def inventoried_recently?
    if inventoried_at.blank? || inventoried_at > 1.years.ago.to_datetime  
      return false
    else
      return true
    end       
  end
  
  def short_type
    if type_of_item.blank?
      return "?"
    else
      type_of_item[0,1].upcase
    end
  end
  
  
  def short_processor
    if processor.length > 10
      return processor[0..7] + '...'
    else
      return processor
    end
  end
  
  def make_and_model
    if make.blank?
      out_make = "?"
    end
    if model.blank?
      out_model = "?"
    end
    return out_make + " " + out_model
  end

  
  def mark_as_inventoried
    self.inventoried_at = Time.now
    self.save
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
  
  def print_dns_names
    if dns_names.empty?
      nil
    else
      dns_names.join(",")
    end
  end
  
  def print_ip
    if ips.empty?
      nil
    else
      ips.first.number
    end
  end
end
