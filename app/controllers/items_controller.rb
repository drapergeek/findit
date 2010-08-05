class ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(params[:item])
    if @item.save
      flash[:notice] = "Successfully created item."
      redirect_to @item
    else
      render :action => 'new'
    end
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      flash[:notice] = "Successfully updated item."
      redirect_to @item
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = "Successfully destroyed item."
    redirect_to items_url
  end
  
  def add_ip
    @item = Item.find(params[:item])
    if params[:ip_selection].blank?
      flash[:notice] = "You must select an IP to add"
      redirect_to :action=>'show', :id=>@item
    else

      @ip = Ip.find(params[:ip_selection])
      @item.ips << @ip
      flash[:notice] = "Added ip #{@ip.number}"
      redirect_to @item
    end
  end
  def remove_ip
    
    @ip = Ip.find(params[:ip])
    @ip.item_id = ""
    if @ip.save
      flash[:notice] = "Removed Ip from item"
    else
      flash[:notice] = "Couldn't remove ip"
    end
    redirect_to :back
  end
end
