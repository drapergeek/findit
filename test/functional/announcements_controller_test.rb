require 'test_helper'

class AnnouncementsControllerTest < ActionController::TestCase

  def test_index
    login
    get :index
    assert_template 'index'
  end
  
  def test_show
    login
    get :show, :id => Announcement.first
    assert_template 'show'
  end
  
  def test_new
    login
    get :new
    assert_template 'new'
  end

  def test_edit
    login
    get :edit, :id => Announcement.first
    assert_template 'edit'
  end
  
  def test_destroy
    login
    announcement = Announcement.first
    delete :destroy, :id => announcement
    assert_redirected_to announcements_url
    assert !Announcement.exists?(announcement.id)
  end
  
  test "can show a page with a valid login in the db" do
    login
    get :index
    assert_template 'index'
  end
  

  
  test "cant load a page at all without a valid login" do
    logout
    get :index
    assert_response :redirect
  end
  
  

end
