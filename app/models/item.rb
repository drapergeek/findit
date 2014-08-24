class Item < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  extend FriendlyId
  friendly_id :name, use: :slugged

  GRAD_SCHOOL_QR_URL = "http://graduateschool.vt.edu/graduate_school/QR/QRCodeURLContent.png?url="

  has_many :ips, :dependent=>:nullify
  has_many :installations, :dependent=>:destroy
  has_many :softwares, :through=>:installations
  has_many :dns_names, :dependent=>:nullify

  def self.not_inventoried_recently
    where("inventoried_at < ? OR inventoried_at IS NULL", 1.years.ago.to_datetime)
  end

  def self.in_use
    where(in_use: true)
  end

  def self.by_type(type)
    where(type_of_item: type)
  end

  delegate :short_location, :to => :location, :allow_nil => true
  delegate :full_name, :to => :location, :prefix => true, :allow_nil => true
  delegate :name, :to => :user, :prefix => true, :allow_nil => true
  delegate :name, to: :operating_system, prefix: true, allow_nil: true

  belongs_to :operating_system
  belongs_to :location
  belongs_to :user

  ITEM_TYPES = ["Desktop","Mobile", "Laptop", "Printer", "Virtual Machine", "Other", "Server"]

  validates :name, :presence => true, :uniqueness =>true
  validates :serial, :uniqueness => true, :allow_nil => true
  validates :vt_tag, :uniqueness => true, :allow_nil => true
  validates :type_of_item, :presence => true
  validates_inclusion_of :type_of_item, :in =>ITEM_TYPES

  before_validation :clear_empty_attrs

  def serial=(input)
    self[:serial] = input.upcase
  end

  ###CSV DEFINITIONS
  comma do
    name
    inventoried_at
    short_location
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
    operating_system_name
    type_of_item
  end

  #this is a list of what security wants for their audit
  comma :sec_review do
    ips "IP"
    name
    operating_system
    type_of_item
    critical
  end

  ###END CSV DEFINITIONS


  def dns_safe_name
    name.sub("_","-")
  end

  def qr_url
    qr_code_url_for(item_url(self))
  end

  def self.search(search)
    if search
      where('name LIKE ? OR vt_tag like ? or model like ? or serial like ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      all
    end
  end


  def inventoried_recently?
    inventoried_at > 1.years.ago.to_datetime
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
    Surpluser.new(self).surplus

    self.save(validate: false)
  end

  def description
    type_of_item.to_s + ": " + name.to_s
  end


  def print_dns_names
    if dns_names.empty?
      nil
    else
      dns_names.join(",")
    end
  end

  def first_ip
    if ips.empty?
      nil
    else
      ips.first.number
    end
  end
  alias_method :print_ip, :first_ip

  protected
  def clear_empty_attrs
    @attributes.each do |key,value|
      self[key] = nil if value.blank?
    end
  end

  private

  def qr_code_url_for(url)
    "#{GRAD_SCHOOL_QR_URL}#{url}&size=150"
  end
end
