class ItemTypesController < ApplicationController
  def index
    @item_types = ItemType.all
    @item_type = ItemType.new
  end

  def create
    item_type = ItemType.new(item_type_params)

    if item_type.save
      redirect_to item_types_path, notice: 'Created!'
    else
      @item_type = item_type
      @item_types = ItemType.all
      render :index, notice: 'Could not save item type'
    end
  end

  def destroy
    ItemType.find(params[:id]).destroy
    redirect_to item_types_path, notice: 'Destroyed!'
  end

  private

  def item_type_params
    params.require(:item_type).permit(:name)
  end
end
