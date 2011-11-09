require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Factory.build(:comment).valid?
  end
  
  test "Test that the user association is correct" do
    comment = Factory.build(:comment, :user => nil)
    assert !comment.valid?, 'The comment should not be valid because it doesnt have a user'
    comment.user = Factory.build(:user)
    assert comment.valid?, 'the ticket should be valid now that it has a user'
  end
  
  test "test that the user is stored properly" do
    user = Factory.build(:user, :first_name => 'Brent', :last_name => 'Montague')
    comment = Factory.build(:comment, :user => user)
    assert_equal comment.user.first_name, 'Brent'
    assert_equal comment.user.last_name, 'Montague'
  end
  
  test "Test that the body is validated correctly" do
    comment = Factory.build(:comment, :body => nil)
    assert !comment.valid?, 'The comment should not be valid because it doesnt have a body'
    comment.body = 'some latin saying here please'
    assert comment.valid?, 'the ticket should be valid now that it has a body'
  end
  
  test "Test that the body is stored correctly" do
    body = 'Some lating saying here'
    comment = Factory.build(:comment, :body => body)
    assert comment.valid?, 'This should be correct because it is simply the default factory'
    assert_equal comment.body, body, 'The body was not stored properly'
  end
  
  test "Test that the subject is stored properly" do
    subject = 'demo subject'
    comment = Factory.build(:comment, :subject => subject)
    assert comment.valid?, 'This should be correct because it is the default factory'
    assert_equal comment.subject, subject, 'The subject was not stored properly'
  end
  
  test "test that the subject is not required" do
    comment = Factory.build(:comment, :subject => nil)
    assert comment.valid?, 'This should be valid because the subject is not needed'
    assert_equals comment.subject, nil, 'This should match up or the subject was not saved right'
  end
  
end
