# Load the rails application
require File.expand_path('../application', __FILE__)
#load the email interceptor
require "development_mail_interceptor"

YAML::ENGINE.yamler= 'syck' if defined?(YAML::ENGINE)

# Initialize the rails application
Findit::Application.initialize!


ActionMailer::Base.smtp_settings = {
  :address              => 'inbound.smtp.vt.edu',
  :port                 => 25,
  :domain               =>"recsports.vt.edu"
}

ActionMailer::Base.default_url_options[:host] = APP_CONFIG['default_url_host']
ActionMailer::Base.default_url_options[:protocol] = APP_CONFIG['default_url_protocol']
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
