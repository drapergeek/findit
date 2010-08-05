require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  
  def setup
    login
  end
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Page.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end

  
  def test_edit
    get :edit, :id => Page.first
    assert_template 'edit'
  end
  

  
  def test_destroy
    page = Page.first
    delete :destroy, :id => page
    assert_redirected_to pages_url
    assert !Page.exists?(page.id)
  end
end
