class Item < ActiveRecord::Base
  has_many :ips, :dependent=>:nullify
  has_many :installations, :dependent=>:destroy
  has_many :softwares, :through=>:installations
  has_many :dns_names, :dependent=>:nullify

  scope :has_ip, :include=> :ips, :conditions=>["ips.id in (SELECT id from ips)"]
  scope :war,includes(:location=>:building).where(:locations=>{:buildings=>{:name=>"War Memorial Hall"}})
  scope :mccomas,includes(:location=>:building).where(:locations=>{:buildings=>{:name=>"McComas Hall"}})
  scope :proc_ratings, :conditions => 'processor_rating IS NOT NULL', :order=>"processor_rating"
  scope :not_inventoried_recently, :conditions=>["inventoried_at < ? OR inventoried_at IS NULL", 1.years.ago.to_datetime]
  scope :in_use, where(:in_use=>true)
  scope :by_type, lambda { |type| {:conditions => {:type_of_item=>type} } }
  scope :no_priority, where(:priority=>nil)
  scope :by_priority, lambda { |priority| where(:priority=>priority)}  
  scope :warranty_ending_in_year, lambda{|year| where("warranty_expires_at like ?", "%#{year}%")}
  scope :computers_purchased_in, lambda{|year| where("purchased_at like ?", "%#{year}%")}

  attr_accessor :new_dns_names
  before_save :create_dns_from_names
  before_save :convert_size_to_bytes
  belongs_to :operating_system
  belongs_to :location
  belongs_to :user


  #default_scope :order=>"name"
  validates_uniqueness_of :name
  validates_uniqueness_of :serial, :allow_nil=>true
  validates_uniqueness_of :vt_tag, :allow_nil=>true
  validates_presence_of :type_of_item
  validates_inclusion_of :type_of_item, :in =>["Desktop","Mobile", "Laptop", "Printer", "Virtual Machine", "Other", "Server"], :message => "Type of item can only be Desktop Laptop Printer Virtual Machine, Server or Other"
  before_validation :clear_empty_attrs

  ###CSV DEFINITIONS
  comma do
    name
    priority
    critical
    inventoried_at
    location
    user
    make
    model
    processor
    processor_rating
    ram
    hard_drive
    serial
    vt_tag
    purchased_at
    warranty_expires_at
    surplused_at
    recieved_at
    os
    type
    ips
    softwares
    dns_names
  end

  #this is a list of what security wants for their audit
  comma :sec_review do
    ips "IP"
    name
    os
    type_of_item
    critical
  end

  ###END CSV DEFINITIONS


  def to_param
    name  
  end

  def dns_safe_name
    name.sub("_","-")
  end

  def qr_url
    "http://graduateschool.vt.edu/graduate_school/QR/QRCodeURLContent.png?url=https://findit.recsports.vt.edu/items/#{name}&size=250"
  end

  def self.search(search)
    if search
      where('name LIKE ? OR vt_tag like ? or model like ? or serial like ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end


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
    if inventoried_at.blank? 
      return false
    elsif inventoried_at > 1.years.ago.to_datetime  
      return true
    else
      return false
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
    out_make = make
    out_model = model
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
    self.save(false)
  end

  def mark_as_surplused
    #set the surplus time
    self.surplused_at = Time.now
    if self.info.nil?
      self.info = ""
    end
    #need to write the note about installations before removing
    self.softwares.each do |s|
      self.info += "\n Software #{s.name} was installed when surplused."
    end
    #remove all the software so that our counts are correct
    self.installations.delete_all
    #now do the same thing for the user
    if self.user
      self.info += "\n The user was #{self.user.full_info} when surplused."
      self.user = nil
    end
    #same for location
    if self.location
      self.info += "\n The item was located at #{self.location.full_name} when surplused"
      self.location = nil
    end

    self.ips.each do |ip|
      self.info +=  "\n The IP #{ip.number} was assigned when surplused."
      ip.item_id = nil
      ip.save
    end

    if self.operating_system
      self.info += "\n The OS #{operating_system.name} was installed when surplused."
      self.operating_system = nil 
    end
    self.in_use = false
    self.save(:validate=>false)
  end

  def description
    type_of_item.to_s + ": " + name.to_s
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

  protected
  def clear_empty_attrs
    @attributes.each do |key,value|
      self[key] = nil if value.blank?
    end
  end
end
