class LabelsController < ApplicationController
  layout 'minimal'

  def show
    @item = Item.friendly.find(params[:id])
    @image_url = ENV['LOGO_IMAGE_URL']
    @company_name = ENV['COMPANY_NAME']
    render 'show'
  end
end
