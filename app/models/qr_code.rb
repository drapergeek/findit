class QrCode
  include Rails.application.routes.url_helpers
  GRAD_SCHOOL_QR_URL = "http://graduateschool.vt.edu/graduate_school/QR/QRCodeURLContent.png?url="

  def initialize(item)
    @item = item
  end

  def url
    qr_code_url_for(item_url(item))
  end

  private

  attr_reader :item

  def qr_code_url_for(url)
    "#{GRAD_SCHOOL_QR_URL}#{url}&size=150"
  end
end
