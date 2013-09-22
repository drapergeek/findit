class SoftwaresController < ApplicationController
  def index
    @softwares = Software.all
  end

  def show
    @software = Software.find(params[:id])
  end

  def new
    @software = Software.new
  end

  def create
    @software = Software.new(software_params)
    if @software.save
      flash[:notice] = "Successfully created software."
      redirect_to softwares_url
    else
      render :action => 'new'
    end
  end

  def edit
    @software = Software.find(params[:id])
  end

  def update
    @software = Software.find(params[:id])
    if @software.update_attributes(software_params)
      flash[:notice] = "Successfully updated software."
      redirect_to softwares_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @software = Software.find(params[:id])
    @software.destroy
    flash[:notice] = "Successfully destroyed software."
    redirect_to softwares_url
  end

  private

  def software_params
    params.require(:software).permit(permitted_params)
  end

  def permitted_params
    [
      :name,
      :license_key,
      :os,
      :number_of_licenses,
      :storage_location,
      :info,
      :operating_system_id,
    ]
  end
end
