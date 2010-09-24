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
  
  def test_edit
    get :edit, :id => Software.first
    assert_template 'edit'
  end
  
  def test_destroy
    software = Software.first
    delete :destroy, :id => software
    assert_redirected_to softwares_url
    assert !Software.exists?(software.id)
  end
end
