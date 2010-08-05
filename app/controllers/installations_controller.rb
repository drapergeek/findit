class InstallationsController < ApplicationController
  def install_software
      if params[:software_selection].blank?
        flash[:notice] = "You must select the software to install"
        redirect_to :back
      elsif params[:item].blank?
        flash[:notice] = "You must choose the item that the software will be installed on."    
        redirect_to :back
      end
      begin
        @installation = Installation.new
        @installation.software = Software.find(params[:software_selection])
        @installation.item = Item.find(params[:item])
        if @installation.save
          flash[:notice] = "The software was succesfully added!"
        else
          flash[:notice] = "There was a problem adding the software"
        end
      rescue ActiveRecord::RecordNotFound => e
        flash[:error] = "There was a problem finding your software to install!"
      ensure
        redirect_to :back
      end
  end
  
  def uninstall_software
      begin
        @software = Software.find(params[:software])
        @item = Item.find(params[:item])
        @item.softwares.delete(@software)
        flash[:notice] = "Succesfully removed software"
      rescue ActiveRecord::RecordNotFound => e
        flash[:error] = "There was a problem finding your software to remove!"
      ensure
        redirect_to :back
      end
  end
end
