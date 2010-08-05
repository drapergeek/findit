class Installation < ActiveRecord::Base
  attr_accessible :software_id, :item_id
  belongs_to :software
  belongs_to :item
end
