class AllowedUsersController < ApplicationController
  def create
    @user = User.find(params[:id])
    @user.can_login = true
    @user.save
    redirect_to users_path, notice: "User is now allowed to sign in"
  end
end
