class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  before_filter :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_url, :notice => exception.message
  end
end
