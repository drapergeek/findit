class Item < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :operating_system
  belongs_to :location
  belongs_to :user

  has_many :ips, dependent: :nullify
  has_many :installations, dependent: :destroy
  has_many :softwares, through: :installations
  has_many :dns_names, dependent: :nullify

  validates :name, presence: true, uniqueness: true
  validates :serial, uniqueness: true, allow_nil: true
  validates :vt_tag, uniqueness: true, allow_nil: true
  validates :type_of_item, presence: true

  delegate :short_location, to: :location, allow_nil: true
  delegate :full_name, to: :location, prefix: true, allow_nil: true
  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :operating_system, prefix: true, allow_nil: true

  def self.not_inventoried_recently
    where("inventoried_at < ? OR inventoried_at IS NULL", 1.years.ago.to_datetime)
  end

  def self.in_use
    where(in_use: true)
  end

  def self.by_type(type)
    where(type_of_item: type)
  end

  def self.search(search)
    if search
      where('name LIKE ? OR vt_tag like ? or model like ? or serial like ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      all
    end
  end

  def serial=(input)
    self[:serial] = input.upcase
  end

  def qr_url
    QrCode.new(self).url
  end

  def mark_as_inventoried
    self.inventoried_at = Time.now
    save(validate: false)
  end

  def mark_as_surplused
    Surpluser.new(self).surplus

    save(validate: false)
  end

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
end
