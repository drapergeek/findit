class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  
  validates :ticket, :user, :presence => true
  validates :body, :presence => true
end
