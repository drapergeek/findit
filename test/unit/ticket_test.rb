require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Factory.build(:ticket).valid?
  end
  
  test "test that a factory has to have a title" do
    ticket = Factory.build(:ticket, :title => '')
    assert !ticket.valid?, 'The ticket should be valid because it doesnt  have a title'
    ticket.title = 'Demo'
    assert ticket.valid?, 'the ticket should be valid now that it has a title'
  end
  
  test "test that a factory has a description" do
    ticket = Factory.build(:ticket, :description => '')
    assert !ticket.valid?, 'The ticket should not be valid because it doesnt  have a description'
    ticket.description = 'Demo'
    assert ticket.valid?, 'the ticket should be valid now that it has a description'
  end
  
  test "test that a factory has a submitter" do
    ticket = Factory.build(:ticket, :submitter => nil)
    assert !ticket.valid?, 'The ticket should not be valid because it doesnt have a submitter'
    ticket.submitter = Factory.build(:user)
    assert ticket.valid?, 'the ticket should be valid now that it has a submitter'
  end
  
  test "test that a factory has to have a status" do
    ticket = Factory.build(:ticket, :status => '')
    assert !ticket.valid?, 'The ticket should not be valid because it doesnt  have a status'
    ticket.status = 'Open'
    assert ticket.valid?, 'the ticket should be valid now that it has a status'
  end
  
  test "test that the submitter is stored properly" do
    user = Factory.build(:user, :first_name => 'Brent', :last_name => 'Montague')
    ticket = Factory.build(:ticket, :submitter => user)
    assert_equal ticket.submitter.first_name, 'Brent'
    assert_equal ticket.submitter.last_name, 'Montague'
  end
  
  test "test that the worker is stored properly" do
    user = Factory.build(:user, :first_name => 'Brent', :last_name => 'Montague')
    ticket = Factory.build(:ticket, :worker => user)
    assert_equal ticket.worker.first_name, 'Brent'
    assert_equal ticket.worker.last_name, 'Montague'
  end

  test "create a ticket from an email" do
    from = "superguy@marvel.com" 
    subject = "Marketing Computer 4 is down"
    body = "The computer in the marketing suite is down, it shows a gray screen with a sad face on it"
    ticket = nil
    assert_difference "Ticket.count" do
      ticket = Ticket.create_from_email(from,subject,body)
    end
    assert_equal from, ticket.submitter_email
    assert_equal subject, ticket.title
    assert_equal body, ticket.description
  end


  test "ticket emails should be parsed for keywords for areas" do
    from = "superguy@marvel.com" 
    subject = "Marketing Computer 4 is down"
    body = "The computer in the marketing suite is down, it shows a gray screen with a sad face on it"
    Factory.create(:area)
    ticket = Ticket.create_from_email(from,subject,body)
    assert !ticket.nil?
    assert_equal "Marketing", ticket.area_name
  end

  test "ticket emails should be parsed for keywords for projects" do
    from = "superguy@marvel.com" 
    subject = "Marketing TV is down"
    body = "The marketing tv in the hallway is down."
    project = Factory.create(:project)
    ticket = Ticket.create_from_email(from,subject,body)
    assert !ticket.nil?
    assert_equal project.name, ticket.project_name
  end

  test "ticket emails that have an id number in the subject should not create a ticket" do
    ticket = Factory.create(:ticket)
    from = "superguy@marvel.com"
    subject = "Re: Rec Sports IT Ticket-ID##{ticket.id}" 
    body = "This problem is still not resolved"
    assert_no_difference "Ticket.all.count" do
      ticket = Ticket.create_from_email(from,subject,body)
    end
  end
  
  test "email on status changed to resolved" do
    ticket = Factory.create(:ticket)
    reset_email
    ticket.status = "Resolved"
    ticket.save
    assert_not_nil last_email.subject
    assert last_email.subject.include?(APP_CONFIG['resolved_notify_subject'])
  end
  
  test "email on status changed to resolved through comment" do
     ticket = Factory.create(:ticket)
     comment = Factory.build(:comment, :ticket_status => "Resolved")
     reset_email
     comment.save
     assert_not_nil last_email.subject
     assert last_email.subject.include?(APP_CONFIG['resolved_notify_subject'])
  end
  
  test "email on worker change" do
    user1 = Factory.create(:user)
    user2 = Factory.create(:user)
    ticket = Factory.create(:ticket, :worker => user1)
    reset_email
    ticket.worker = user2
    ticket.save
    assert_not_nil last_email.to, "The to field should not be nil"
    assert last_email.to.include?(user2.email)
    assert !last_email.to.include?(user1.email)
    assert_not_nil last_email.subject, "The subject field should not be nil"
    assert last_email.subject.include?(APP_CONFIG['worker_notify_subject'])
  end

end
