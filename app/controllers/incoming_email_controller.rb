class IncomingEmailController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :check_for_valid_login

  def index
    if params[:mail]
      mail = Mail.read_from_string(params[:mail])
      logger.info mail.from.addresses
      logger.info "Subject: " + mail.subject
      logger.info "Body: " + mail.body.decoded
    end
    redirect_to root_url
  end
end
