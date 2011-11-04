class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :set_login
  before_filter :check_for_valid_login
  helper_method :current_user


  private 


  def current_user
    return @current_user if defined?(@current_user)
    @current_user = User.find_by_login(session[:cas_user])
    if @current_user
      unless @current_user.can_login == true
        @current_user = nil
      end
      unless @current_user.nil?
        @current_user.last_login_ip = request.remote_ip 
        @current_user.last_login = Time.now
        @current_user.save!
      end
    end
  end

  def set_login
    if Rails.env != "production"
      session[:cas_user] = "gdraper"
    end
  end


  def check_for_valid_login
    unless current_user
      #this user can't be found so get them out of here!
      CASClient::Frameworks::Rails::Filter.logout(self)
    end
  end

end
