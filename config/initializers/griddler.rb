Griddler.configure do |config|
  config.processor_class = EmailProcessor
  config.to = :hash
  config.from = :hash
  config.reply_delimiter = '-- REPLY ABOVE THIS LINE --'
  config.email_service = :sendgrid
end
