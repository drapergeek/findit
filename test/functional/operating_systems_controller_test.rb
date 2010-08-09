require 'test_helper'

class OperatingSystemsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => OperatingSystem.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    OperatingSystem.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    OperatingSystem.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to operating_system_url(assigns(:operating_system))
  end
  
  def test_edit
    get :edit, :id => OperatingSystem.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    OperatingSystem.any_instance.stubs(:valid?).returns(false)
    put :update, :id => OperatingSystem.first
    assert_template 'edit'
  end
  
  def test_update_valid
    OperatingSystem.any_instance.stubs(:valid?).returns(true)
    put :update, :id => OperatingSystem.first
    assert_redirected_to operating_system_url(assigns(:operating_system))
  end
  
  def test_destroy
    operating_system = OperatingSystem.first
    delete :destroy, :id => operating_system
    assert_redirected_to operating_systems_url
    assert !OperatingSystem.exists?(operating_system.id)
  end
end
