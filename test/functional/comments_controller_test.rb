require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Comment.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    comment = Factory.build(:comment, :ticket=>nil, :user=>nil).attributes.symbolize_keys
    post :create, comment
    assert_template 'new'
  end

  def test_create_valid
    ticket = Factory(:ticket)
    user = Factory(:user)
    comment = Factory.build(:comment, :ticket=>ticket, :user => user)
    assert comment.valid?
    comment = comment.attributes.symbolize_keys
    post :create, :comment=>comment
    assert_redirected_to ticket_url(comment[:ticket_id])
  end

  def test_edit
    get :edit, :id => Comment.first
    assert_template 'edit'
  end

  def test_update_invalid
    Comment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Comment.first
    assert_template 'edit'
  end
  
  def test_update_status_in_comment
    ticket = Factory(:ticket)
    comment = Factory.build(:comment, :ticket=>ticket, :ticket_status => "Resolved")
    assert comment.valid?
    comment = comment.attributes.symbolize_keys
    post :create, :comment=>comment
    assert_redirected_to ticket_url(comment[:ticket_id])
  end

  def test_update_valid
    Comment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Comment.first
    assert_redirected_to comment_url(assigns(:comment))
  end

  def test_destroy
    comment = Comment.first
    delete :destroy, :id => comment
    assert_redirected_to comments_url
    assert !Comment.exists?(comment.id)
  end
end
