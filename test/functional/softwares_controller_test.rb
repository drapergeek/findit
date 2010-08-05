require 'test_helper'

class SoftwaresControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Software.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Software.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Software.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to software_url(assigns(:software))
  end
  
  def test_edit
    get :edit, :id => Software.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Software.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Software.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Software.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Software.first
    assert_redirected_to software_url(assigns(:software))
  end
  
  def test_destroy
    software = Software.first
    delete :destroy, :id => software
    assert_redirected_to softwares_url
    assert !Software.exists?(software.id)
  end
end
