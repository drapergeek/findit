require 'test_helper'

class ServicesControllerTest < ActionController::TestCase
  def setup
    login
  end
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Service.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_edit
    get :edit, :id => Service.first
    assert_template 'edit'
  end
  
  
  def test_destroy
    service = Service.first
    delete :destroy, :id => service
    assert_redirected_to services_url
    assert !Service.exists?(service.id)
  end
end
