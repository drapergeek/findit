class IncomingEmailController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :check_for_valid_login

  def index
    logger.info "I got the email"
    logger.info email.class
    logger.info email.to_yaml
  end
end
