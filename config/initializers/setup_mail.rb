require "development_mail_interceptor"

ActionMailer::Base.smtp_settings = {
  :address              => 'inbound.smtp.vt.edu',
  :port                 => 25,
  :domain               =>"recsports.vt.edu"
}

ActionMailer::Base.default_url_options[:host] = APP_CONFIG['default_url_host']
ActionMailer::Base.default_url_options[:protocol] = APP_CONFIG['default_url_protocol']
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
