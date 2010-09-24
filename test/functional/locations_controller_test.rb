require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Location.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  

  
  def test_edit
    get :edit, :id => Location.first
    assert_template 'edit'
  end

  
  def test_destroy
    location = Location.first
    delete :destroy, :id => location
    assert_redirected_to locations_url
    assert !Location.exists?(location.id)
  end
end
