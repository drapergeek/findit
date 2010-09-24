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
  

  
  def test_edit
    get :edit, :id => Ip.first
    assert_template 'edit'
  end

  def test_destroy
    ip = Ip.first
    delete :destroy, :id => ip
    assert_redirected_to ips_url
    assert !Ip.exists?(ip.id)
  end
end
