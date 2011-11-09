class IncomingEmailController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :check_for_valid_login

  def index
    if params[:mail]
      mail = Mail.read_from_string(params[:mail])
      logger.info "Incoming mail from #{mail.from} subject: #{mail.subject}"
      if mail.multipart?
        body = mail.parts[0].body.decoded
      else
        body = mail.body.decoded
      end
      Ticket.create_from_email(mail.from, mail.subject, body)
    end
    redirect_to root_url
  end
end
