class IncomingEmailController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :check_for_valid_login

  def index
    logger.info "I got the email"
    mail = Mail.read(params[:mail])
    logger.info mail.from.address
    logger.info mail.subject
    logger.info mail.body.decoded
    redirect_to root_url
  end
end
