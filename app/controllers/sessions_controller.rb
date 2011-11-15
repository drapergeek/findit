class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_login(auth["uid"]) 
    if user && user.can_login
      session[:user_id] = user.id
      redirect_to home_url, :notice => "Signed in!"
    else
      session[:user_id] = nil
      redirect_to root_url, :notice=>"User not found or authorized"
    end
  end
  
  
  def destroy
    session[:user_id] = nil
    redirect_to "https://auth.vt.edu/logout"
  end
end
