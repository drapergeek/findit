class IncomingEmailController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :check_for_valid_login

  def index
    logger.info "Got the incoming email!"
    logger.info params
    redirect_to root_url
  end
end
