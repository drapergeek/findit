class DnsNamesController < ApplicationController
    prepend_before_filter CASClient::Frameworks::Rails::Filter
  def index
    @dns_names = DnsName.all
  end
  
  def show
    @dns_name = DnsName.find(params[:id])
  end
  
  def new
    @dns_name = DnsName.new
  end
  
  def create
    @dns_name = DnsName.new(params[:dns_name])
    if @dns_name.save
      flash[:notice] = "Successfully created dns name."
      redirect_to @dns_name
    else
      render :action => 'new'
    end
  end
  
  def edit
    @dns_name = DnsName.find(params[:id])
  end
  
  def update
    @dns_name = DnsName.find(params[:id])
    if @dns_name.update_attributes(params[:dns_name])
      flash[:notice] = "Successfully updated dns name."
      redirect_to @dns_name
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @dns_name = DnsName.find(params[:id])
    @dns_name.destroy
    flash[:notice] = "Successfully destroyed dns name."
    redirect_to dns_names_url
  end
end
