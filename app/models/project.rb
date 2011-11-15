class Project < ActiveRecord::Base
  has_many :tickets
  
  validates :name, :presence => true
  
  def to_s
    name
  end
end
