class SessionsController < ApplicationController
  skip_before_filter :check_for_valid_login, :except=>[:destroy]

  def index
     
  end
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_login(auth["uid"]) 
    if user && user.can_login
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Signed in!"
    else
      session[:user_id] = nil
      redirect_to no_auth_url, :notice=>"User not found or authorized"
    end
  end
  
  
  def destroy
    session[:user_id] = nil
    redirect_to "https://auth.vt.edu/logout"
  end
end
