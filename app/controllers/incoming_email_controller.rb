class IncomingEmailController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :check_for_valid_login

  def index
    if params[:mail]
      mail = IncomingEmail.new(params[:mail]) 
      Ticket.create_from_email(mail.from, mail.subject, mail.body)
      logger.info "Incoming mail from #{mail.from} subject: #{mail.subject}"
    end
    redirect_to root_url
  end
end
