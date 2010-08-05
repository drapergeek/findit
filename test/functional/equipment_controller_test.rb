require 'test_helper'

class EquipmentControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Equipment.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Equipment.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Equipment.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to equipment_url(assigns(:equipment))
  end
  
  def test_edit
    get :edit, :id => Equipment.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Equipment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Equipment.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Equipment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Equipment.first
    assert_redirected_to equipment_url(assigns(:equipment))
  end
  
  def test_destroy
    equipment = Equipment.first
    delete :destroy, :id => equipment
    assert_redirected_to equipment_url
    assert !Equipment.exists?(equipment.id)
  end
end
