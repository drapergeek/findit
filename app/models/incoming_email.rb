class IncomingEmail < Object
  attr_accessor :body, :from, :subject, :mail_object

  def initialize(input)
    @mail_object = Mail.read_from_string(input)
    if @mail_object.multipart?
      if @mail_object.parts[0].parts.count > 1
        @body = @mail_object.parts[0].parts[0].body
      else
        @body = @mail_object.parts[0].body
      end
    else
      @body = @mail_object.body
    end

    @body = @body.to_s
    @subject = @mail_object.subject
    @from = @mail_object.from
  end
end
