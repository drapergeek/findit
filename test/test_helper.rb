ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require File.dirname(__FILE__) + "/factories"
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
     CASClient::Frameworks::Rails::Filter.fake("gdraper")
  end
  
  def login_not_authorized
    CASClient::Frameworks::Rails::Filter.fake("homer")
  end
  
  def logout
    current_user = nil
    CASClient::Frameworks::Rails::Filter.fake(nil)    
  end
end
