class User < ActiveRecord::Base
  attr_accessible :login, :first_name, :last_name, :last_login, :last_login_ip, :can_login
  has_many :items
  def full_name
    [first_name, last_name].join(" ")
  end
end
