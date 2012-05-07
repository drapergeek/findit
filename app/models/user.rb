class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :login, :first_name, :last_name,:email
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
    if full_name
      full_name
    elsif email
      email
    else
      "No Info"
    end
  end
  
  def reverse_name
    [last_name, first_name].join(", ")
  end

  def to_s
    name
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
      user.save_with_random_password
    end
    user
  end

  #devise methods
  def active_for_authentication?
    super && can_login?
  end

  def inactive_message
    if !can_login?
      :not_approved
    else
      super
    end
  end

  def save_with_random_password
    random_string = SecureRandom.hex
    self.password = random_string
    self.password_confirmation = random_string
    save
  end
end
