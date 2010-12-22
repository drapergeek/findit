class ItemsController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    @items = Item.search(params[:search]).order(sort_column + " " +sort_direction).paginate(:per_page=>20, :page=>params[:page])
  #  if params[:type]
   #   @items = @items.where(:type_of_item=>params[:type])
  #  end
    @title = "Items"
  end
  
  def not_checked
    @items = Item.not_inventoried_recently.paginate(:per_page=>100, :page=>params[:page])
    render :template=>'items/index'
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def new
    @item = Item.new
    @item.in_use = true
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
  
  def remove_dns_name
    @dns = DnsName.find(params[:name]).destroy
    redirect_to :back
  end
  
  def mark_as_inventoried
    @item = Item.find(params[:id])
    @item.mark_as_inventoried
    flash[:notice] = "Item is inventoried as of #{@item.inventoried_at}"
    redirect_to @item
  end
  
  def surplus
    @item = Item.find(params[:id])
    if @item.mark_as_surplused
      flash[:notice] = "Item is surplused as of #{@item.surplused_at}"
    else
      flash[:notice] = "There was a problem updating the record"
    end
    redirect_to @item
  end
  
  
  private
  def sort_column
    Item.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
