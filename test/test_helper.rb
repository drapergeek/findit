ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # 
  # 
  def login
    #this method will login as a user who has been defined in the system
    session[:user_id] = 1 
  end
  
  def login_not_authorized
    session[:user_id] = 2
  end
  
  def logout
    current_user = nil
  end


  def last_email
    ActionMailer::Base.deliveries.last
  end
  
  def reset_email
    ActionMailer::Base.deliveries = []
  end
end
