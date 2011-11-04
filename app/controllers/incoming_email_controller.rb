class IncomingEmailController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :check_for_valid_login

  def index
    logger.info "I got the email"
    logger.info params[:mail].class
    logger.info Rails.env
    mail = Mail.read(params[:mail])
    logger.info mail.class
    logger.info mail.to_s
    redirect_to root_url
  end
end
