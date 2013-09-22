class ItemsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    logger.info Rails.env
    if params[:in_use]=="false"
      if params[:no_priority]=="true"
        @items = Item.search(params[:search]).order(sort_column + " " +sort_direction).no_priority
      else
        @items = Item.search(params[:search]).order(sort_column + " " +sort_direction)
      end
    else
      if params[:no_priority]=="true"
        @items = Item.search(params[:search]).in_use.order(sort_column + " " +sort_direction).no_priority
      else
        @items = Item.search(params[:search]).in_use.order(sort_column + " " +sort_direction)
      end
    end
    @title = "Items"
    respond_to do |format|
      format.html {@items = @items.paginate(:per_page=>20, :page=>params[:page]) }
      format.csv {
        #did we get a format
        if params[:csv_type].blank?
          send_data(@items.all.to_comma)
        else
          send_data(@items.all.to_comma(params[:csv_type].to_sym))
        end
      }
    end

    #  if params[:type]
    #   @items = @items.where(:type_of_item=>params[:type])
    #  end

  end


  def not_checked
    @items = Item.not_inventoried_recently.paginate(:per_page=>100, :page=>params[:page])
    render :template=>'items/index'
  end

  def show
    @item = Item.find_by_name(params[:id])
  end

  def new
    @item = Item.new
    @item.in_use = true
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "Successfully created item."
      redirect_to @item
    else
      render :action => 'new'
    end
  end

  def edit
    @item = Item.find_by_name(params[:id])
    unless @item
      flash[:notice] = "The item can't be found"
      redirect_to root_url
    end
  end

  def update
    @item = Item.find_by_name(params[:id])
    if @item.update_attributes(item_params)
      flash[:notice] = "Successfully updated item."
      redirect_to @item
    else
      render :action => 'edit'
    end
  end

  def destroy
    @item = Item.find_by_name(params[:id])
    @item.destroy
    flash[:notice] = "Successfully destroyed item."
    redirect_to items_url
  end

  def add_ip
    @item = Item.find_by_name(params[:item])
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
    @ip = Ip.find_by_id(params[:ip])
    @item = Item.find_by_id(@ip.item)
    @ip.item_id = ""
    if @ip.save
      flash[:notice] = "Removed Ip from item"
    else
      flash[:notice] = "Couldn't remove ip"
    end
    redirect_to @item
  end

  def remove_dns_name
    @dns = DnsName.find(params[:name]).destroy
    redirect_to :back
  end

  def mark_as_inventoried
    @item = Item.find_by_name(params[:id])
    @item.mark_as_inventoried
    flash[:notice] = "Item is inventoried as of #{@item.inventoried_at}"
    redirect_to @item
  end

  def surplus
    @item = Item.find_by_name(params[:id])
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

  def item_params
    params.require(:item).permit(permitted_params)
  end

  def permitted_params
    [
      :name,
      :make,
      :model,
      :processor,
      :ram,
      :hard_drive,
      :serial,
      :vt_tag,
      :purchased_at,
      :warranty_expires_at,
      :recieved_at,
      :os,
      :type_of_item,
      :operating_system_id,
      :location_id,
      :user_id,
      :info,
      :in_use,
      :critical,
      :priority,
    ]
  end
end
