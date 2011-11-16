class User < ActiveRecord::Base
  attr_accessible :login, :first_name, :last_name, :last_login, :last_login_ip, :can_login, :email
  has_many :items
  has_many :tickets
  belongs_to :area
  has_many :comments
  
  scope :workers, where(:can_login => true)

  validates_uniqueness_of :login, :if=>lambda{!self.login.nil?}
  def full_name
    [first_name, last_name].join(" ")
  end

  def name
   full_name 
  end
  
  def reverse_name
    [last_name, first_name].join(", ")
  end

  def to_s
    full_name
  end
  def full_info
    [first_name, last_name, login].join(" ")  
  end


  def self.find_or_create_by_email(email)
    user = User.find_by_email(email)
    if user
      return user 
    else
      user = User.create(:email=>email, :first_name=>"No", :last_name=>"Name")
      user.login = email.split("@")[0]
      user.save!
    end
    user
  end
end
