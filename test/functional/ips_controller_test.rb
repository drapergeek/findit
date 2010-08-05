require 'test_helper'

class IpsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Ip.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Ip.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Ip.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to ip_url(assigns(:ip))
  end
  
  def test_edit
    get :edit, :id => Ip.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Ip.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Ip.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Ip.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Ip.first
    assert_redirected_to ip_url(assigns(:ip))
  end
  
  def test_destroy
    ip = Ip.first
    delete :destroy, :id => ip
    assert_redirected_to ips_url
    assert !Ip.exists?(ip.id)
  end
end
