class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} - #{message.subject}"
    message.to = APP_CONFIG['default_email_for_interceptor']
  end
end