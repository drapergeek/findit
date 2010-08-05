require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    login
  end
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => User.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end

  
  def test_edit
    get :edit, :id => User.first
    assert_template 'edit'
  end
  
  
  def test_destroy
    user = User.first
    delete :destroy, :id => user
    assert_redirected_to users_url
    assert !User.exists?(user.id)
  end
end
