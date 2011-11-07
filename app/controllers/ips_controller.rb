class IpsController < ApplicationController
 prepend_before_filter { |nothing|  CASClient::Frameworks::Rails::Filter if Rails.env=="production" }
  def index
    if params[:unassigned]
      if Rails.env == "production"
        @ips = Ip.unassigned.order("INET_ATON(number) ASC").group_by(&:building)
      else 
        @ips = Ip.unassigned.group_by(&:building)
      end
    else
      if Rails.env == "production"
        @ips = Ip.order("INET_ATON(number) ASC").group_by(&:building)
      else
        @ips = Ip.order(:number).group_by(&:building)
      end
    end
  end
  
  def show
    @ip = Ip.find(params[:id])
  end
  
  def new
    @ip = Ip.new
  end
  
  def create
    @ip = Ip.new(params[:ip])
    if @ip.save
      flash[:notice] = "Successfully created ip #{@ip.number}"
      redirect_to :action=>'new'
    else
      render :action => 'new'
    end
  end
  
  def edit
    @ip = Ip.find(params[:id])
  end
  
  def update
    @ip = Ip.find(params[:id])
    if @ip.update_attributes(params[:ip])
      flash[:notice] = "Successfully updated ip."
      redirect_to @ip
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @ip = Ip.find(params[:id])
    @ip.destroy
    flash[:notice] = "Successfully destroyed ip."
    redirect_to ips_url
  end
end
