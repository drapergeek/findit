require 'test_helper'

class BuildingsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Building.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end

  
  def test_edit
    get :edit, :id => Building.first
    assert_template 'edit'
  end
  

  def test_destroy
    building = Building.first
    delete :destroy, :id => building
    assert_redirected_to buildings_url
    assert !Building.exists?(building.id)
  end
end
