class PageObject
  include Capybara::DSL

  def initialize(attributes = {})
    attributes.each do |key, value|
      public_send("#{key.to_s}=", value)
    end
  end
end
