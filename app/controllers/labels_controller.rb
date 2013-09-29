class LabelsController < ApplicationController
  layout 'minimal'

  def show
    @item = Item.friendly.find(params[:id])
    @image_url = ENV['LOGO_IMAGE_URL']
    render 'show'
  end
end
