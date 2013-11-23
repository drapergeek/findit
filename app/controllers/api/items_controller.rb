class Api::ItemsController < ApplicationController
  respond_to :json

  def index
    respond_with Item.all
  end
end
