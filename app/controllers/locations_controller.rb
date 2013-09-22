class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      flash[:notice] = "Successfully created location."
      redirect_to locations_path
    else
      render :action => 'new'
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(location_params)
      flash[:notice] = "Successfully updated location."
      redirect_to locations_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    flash[:notice] = "Successfully destroyed location."
    redirect_to locations_path
  end

  private

  def location_params
    params.require(:location).permit(:name, :info, :building_id)
  end
end
