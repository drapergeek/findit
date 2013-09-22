class Installation < ActiveRecord::Base
  belongs_to :software
  belongs_to :item
end
