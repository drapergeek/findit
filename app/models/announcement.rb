class Announcement < ActiveRecord::Base
  attr_accessible :name, :info, :start_at, :end_at
end
