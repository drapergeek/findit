class DnsName < ActiveRecord::Base
  attr_accessible :name
  belongs_to :item
  
  def to_s
    name
  end
end
