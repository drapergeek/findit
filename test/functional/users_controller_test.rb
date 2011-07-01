require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    login
  end
  def test_index
    get :index
    assert_template 'index'
  end

  def test_index_shows_name
    User.create(:login=>"stupid", :first_name=>"Stu", :last_name=>"Pid") 
    get :index
    assert_template 'index'
    assert_select "td","Pid, Stu"
    assert_select "td", "stupid"
    assert_select "th", "Name"
    assert_select "th", "Login"
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
