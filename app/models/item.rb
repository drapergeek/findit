class Item < ActiveRecord::Base
  has_many :ips, :dependent=>:nullify
  has_many :installations, :dependent=>:destroy
  has_many :softwares, :through=>:installations
  has_many :dns_names, :dependent=>:nullify
  named_scope :has_ip, :include=> :ips, :conditions=>["ips.id in (SELECT id from ips)"]
  named_scope :proc_ratings, :conditions => 'processor_rating IS NOT NULL', :order=>"processor_rating"
  attr_accessor :new_dns_names
  before_save :create_dns_from_names
  before_save :convert_size_to_bytes
  belongs_to :operating_system
  belongs_to :location
  belongs_to :user
  default_scope :order=>"name"
  validates_uniqueness_of :name
  validates_uniqueness_of :serial, :allow_nil=>true
  validates_uniqueness_of :vt_tag, :allow_nil=>true
  validates_presence_of :type_of_item
  validates_inclusion_of :type_of_item, :in =>["Desktop", "Laptop", "Printer", "Virtual Machine", "Other", "Server"], :message => "Type of item can only be Desktop Laptop Printer Virtual Machine, Server or Other"
  before_validation :clear_empty_attrs
  named_scope :by_type, lambda { |type| {:conditions => {:type_of_item=>type} } }
  
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
    self.surplused_at = Time.now
    self.save(false)
  end
  
  def info
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
