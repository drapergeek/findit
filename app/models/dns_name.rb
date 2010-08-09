class DnsName < ActiveRecord::Base
  attr_accessible :name
  belongs_to :item
end
