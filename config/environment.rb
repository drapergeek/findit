# Load the rails application
require File.expand_path('../application', __FILE__)
#load the email interceptor
require "development_mail_interceptor"


# Initialize the rails application
Findit::Application.initialize!

ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
Rails.application.routes.default_url_options[:host] = ENV['URL']

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}
