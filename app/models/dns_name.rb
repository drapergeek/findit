class DnsName < ActiveRecord::Base
  belongs_to :item

  def to_s
    name
  end
end
