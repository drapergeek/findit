class ReportsController < ApplicationController
  def index
    
  end
  def dns
    @items = Item.has_ip
    render :action=>"dns", :layout=>false
  end
end
