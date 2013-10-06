class BuildingsController < ApplicationController
  def index
    @buildings = Building.all
    @building = new_or_existing_building
  end

  def create
    Building.create(building_params)
    redirect_to buildings_path, notice: 'Created!'
  end

  def update
    Building.find(params[:id]).update_attributes(building_params)
    redirect_to buildings_path, notice: 'Updated!'
  end

  def destroy
    Building.find(params[:id]).destroy
    redirect_to buildings_path, notice: 'Destroyed!'
  end

  private

  def building_params
    params.require(:building).permit(:name, :info)
  end

  def new_or_existing_building
    if params[:building_id]
      Building.find(params[:building_id])
    else
      Building.new
    end
  end
end
