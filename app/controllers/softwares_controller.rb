class SoftwaresController < ApplicationController
    prepend_before_filter CASClient::Frameworks::Rails::Filter
  def index
    @softwares = Software.all
  end
  
  def show
    @software = Software.find(params[:id])
  end
  
  def new
    @software = Software.new
  end
  
  def create
    @software = Software.new(params[:software])
    if @software.save
      flash[:notice] = "Successfully created software."
      redirect_to softwares_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @software = Software.find(params[:id])
  end
  
  def update
    @software = Software.find(params[:id])
    if @software.update_attributes(params[:software])
      flash[:notice] = "Successfully updated software."
      redirect_to softwares_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @software = Software.find(params[:id])
    @software.destroy
    flash[:notice] = "Successfully destroyed software."
    redirect_to softwares_url
  end
end
