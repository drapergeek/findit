class AreasController < ApplicationController
  def index
    @areas = Area.all
  end

  def new
    @area = Area.new
  end

  def create
    @area = Area.new(params[:area])
    if @area.save
      redirect_to areas_path, :notice => "Successfully created area."
    else
      render :action => 'new'
    end
  end

  def edit
    @area = Area.find(params[:id])
  end

  def update
    @area = Area.find(params[:id])
    if @area.update_attributes(params[:area])
      redirect_to areas_path, :notice  => "Successfully updated area."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @area = Area.find(params[:id])
    @area.destroy
    redirect_to areas_path, :notice => "Successfully destroyed area."
  end
end
