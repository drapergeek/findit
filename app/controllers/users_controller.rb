class UsersController < ApplicationController
  def index
    @users = User.order "last_name"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save_with_random_password
      redirect_to users_path, notice: "Added User"
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
