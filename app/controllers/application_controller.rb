# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  if ENV['RAILS_ENV'] == "development"
    before_filter :set_login
  else
    before_filter CASClient::Frameworks::Rails::Filter
  end
  before_filter :check_for_valid_login

  
  
  helper_method :current_user
  
  
  private 
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = User.find_by_login(session[:cas_user])
    unless @current_user.nil?
      @current_user.last_login_ip = request.remote_ip 
      @current_user.last_login = Time.now
      @current_user.save!
    end
  end
  
  
  def set_login
    session[:cas_user] = "gdraper"
  end
  
  
  def check_for_valid_login
    unless current_user
      #this user can't be found so get them out of here!
      CASClient::Frameworks::Rails::Filter.logout(self)
    end
  end
    
  
  
end
