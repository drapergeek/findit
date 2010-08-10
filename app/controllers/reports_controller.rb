class ReportsController < ApplicationController
  layout nil
  def dns
    @items = Item.has_ip
    
    
  end
end
