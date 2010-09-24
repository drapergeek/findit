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


  def test_edit
    get :edit, :id => OperatingSystem.first
    assert_template 'edit'
  end


  
  def test_destroy
    operating_system = OperatingSystem.first
    delete :destroy, :id => operating_system
    assert_redirected_to operating_systems_url
    assert !OperatingSystem.exists?(operating_system.id)
  end
end
