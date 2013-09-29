# Load the rails application
require File.expand_path('../application', __FILE__)
#load the email interceptor
require "development_mail_interceptor"


# Initialize the rails application
Findit::Application.initialize!


ActionMailer::Base.smtp_settings = {
  :address              => 'inbound.smtp.vt.edu',
  :port                 => 25,
  :domain               =>"recsports.vt.edu"
}

ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
Rails.application.routes.default_url_options[:host] = ENV['URL']
