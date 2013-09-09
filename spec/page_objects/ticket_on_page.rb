class TicketOnPage
  include Capybara::DSL

  def initialize(attributes = {})
    attributes.each do |key, value|
      public_send("#{key.to_s}=", value)
    end
  end

  def with_basic_information
    self.title = 'Broken Computer'
    self.description = 'My computer is broken'
    self.status = 'New'
    self.submitter = User.first.full_name
    self.submit!
    self
  end

  def title=(title)
    fill_in 'Title', with: title
  end

  def description=(description)
    fill_in 'Description', with: description
  end

  def submitter=(submitter)
    select submitter, from: 'Submitter'
  end

  def status=(status)
    select status, from: 'Status'
  end

  def submit!
    click_on 'Create Ticket'
  end

  def add_comment(comment_text, options = {})
    if options[:status]
      select options[:status], from: 'Ticket status'
    end

    fill_in 'Body', with: comment_text
    click_on 'Create Comment'
  end

  def has_title?(title)
    page.has_selector?("[data-role=title]", text: title)
  end

  def has_status?(status)
    page.has_content? "Status: #{status}"
  end

  def has_submitter?(submitter)
    page.has_content? "Submitter: #{submitter}"
  end

  def has_description?(description)
    page.has_content? "Description: #{description}"
  end

  def has_comment?(comment_text, options={})
    user = options[:user] || User.first.name
    page.has_selector?("[data-role=comment]", text: comment_text) &&
      comment_user_is_correct?(options[:user])
  end

  def closed?
    page.has_selector?('[data-role=status]', text: 'Resolved')
  end

  private

  def comment_user_is_correct?(user = User.first.name)
    page.has_selector?("[data-role=comment-user]", text: user)
  end
end
