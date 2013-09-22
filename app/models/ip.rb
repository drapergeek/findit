class Ip < ActiveRecord::Base
  validates_presence_of :building_id
  validates_presence_of :number
  belongs_to :item
  belongs_to :building

  def self.unassigned
    where('item_id is NULL')
  end

  def last_octet
    number.split(".")[3]
  end

  def to_s
    number
  end
end
