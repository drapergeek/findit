require 'test_helper'

class ServiceTypesControllerTest < ActionController::TestCase
  
  def setup
    login
  end
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => ServiceType.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  
  def test_edit
    get :edit, :id => ServiceType.first
    assert_template 'edit'
  end
  
  def test_destroy
    service_type = ServiceType.first
    delete :destroy, :id => service_type
    assert_redirected_to service_types_url
    assert !ServiceType.exists?(service_type.id)
  end
end
