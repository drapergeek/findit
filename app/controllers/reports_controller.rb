class ReportsController < ApplicationController
  def index
    
  end
  
  def dns
    @war_items = Item.has_ip.war
    @mccomas_items = Item.has_ip.mccomas
    render :action=>"dns", :layout=>false
  end
  
  
  def proc_ratings
    @items = Item.proc_ratings
  end
  
  def upgrades
    #get the year first
    this_year = Time.now.year.to_s
    next_year = Time.now.year+1
    next_year = next_year.to_s
    six_years_ago = Time.now.year-6
    six_years_ago = six_years_ago.to_s
    five_years_ago = Time.now.year-5
    five_years_ago = five_years_ago.to_s
    four_years_ago = Time.now.year-4
    four_years_ago = four_years_ago.to_s
    #first we want to see the computers that are priority 1 that expire this year
    @priority1_this_year = Item.by_priority(1).warranty_ending_in_year(this_year).in_use
    #then we want to see the computers that are priority 1 that expire next year
    @priority1_next_year = Item.by_priority(1).warranty_ending_in_year(next_year).in_use    
    #then we want to see that computers that are priority 2 that were bought more than 6 years ago this year
    @priority2_this_year = Item.by_priority(2).computers_purchased_in(six_years_ago).in_use
    #then we want to see that computers that are priority 2 that were bought more than 6 years ago next year
    @priority2_next_year = Item.by_priority(2).computers_purchased_in(five_years_ago).in_use
    #priority 1 bought more than 4 years ago
    @priority1_older = Item.by_priority(1).computers_purchased_in(four_years_ago).in_use
  end
end
