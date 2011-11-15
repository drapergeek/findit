class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :check_for_valid_login
  helper_method :current_user

  private 

  def current_user
   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_for_valid_login
    if Rails.env !="production"
        session[:user_id] = User.find_by_login(APP_CONFIG['default_user'])
        current_user
    end
    ip = request.remote_ip
    unless current_user
     #this user can't be found so get them out of here!
     logger.info "Current user can't be found for some reason..."
     session[:user_id] = nil
     flash[:notice] = "You must be signed in to view this page"
     redirect_to sessions_path
     return
    end
    logger.info "User: #{current_user.login} IP: #{ip}"
  end

end
