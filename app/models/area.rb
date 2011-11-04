class Area < ActiveRecord::Base
  has_many :users
  has_many :tickets
  
  validates :name, :presence => true
end
