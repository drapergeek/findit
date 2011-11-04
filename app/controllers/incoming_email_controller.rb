class IncomingEmailController < ApplicationController

  def index
    logger.info "Got the incoming email!"
    logger.info params
    redirect_to root_url
  end
end
