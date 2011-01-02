class ReportsController < ApplicationController
  def index
    
  end
  def dns
    @items = Item.has_ip
    render :action=>"dns", :layout=>false
  end
  
  
  def proc_ratings
    @items = Item.proc_ratings
  end
  
  def sec_review
    @items = Item.in_use
  end
end
