class OperatingSystemsController < ApplicationController
  def index
    @operating_systems = OperatingSystem.all
  end

  def new
    @operating_system = OperatingSystem.new
  end

  def create
    @operating_system = OperatingSystem.new(params[:operating_system])
    if @operating_system.save
      flash[:notice] = "Successfully created operating system."
      redirect_to operating_systems_path
    else
      render :action => 'new'
    end
  end

  def edit
    @operating_system = OperatingSystem.find(params[:id])
  end

  def update
    @operating_system = OperatingSystem.find(params[:id])
    if @operating_system.update_attributes(params[:operating_system])
      flash[:notice] = "Successfully updated operating system."
      redirect_to operating_systems_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @operating_system = OperatingSystem.find(params[:id])
    @operating_system.destroy
    flash[:notice] = "Successfully destroyed operating system."
    redirect_to operating_systems_path
  end
end
