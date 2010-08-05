require 'test_helper'

class InstallationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Installations.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Installations.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Installations.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to installations_url(assigns(:installations))
  end
  
  def test_edit
    get :edit, :id => Installations.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Installations.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Installations.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Installations.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Installations.first
    assert_redirected_to installations_url(assigns(:installations))
  end
  
  def test_destroy
    installations = Installations.first
    delete :destroy, :id => installations
    assert_redirected_to installations_url
    assert !Installations.exists?(installations.id)
  end
end
