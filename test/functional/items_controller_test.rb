require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Item.first.name
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end

  def test_edit
    item = Factory.create(:item)
    get :edit, :id => item.name
    assert_template 'edit'
  end
  
  test "removing an ip" do
    item = Factory(:item)
    ip = Factory(:ip, :item => item)
    get :remove_ip, :ip => ip.id
    assert_redirected_to item_url(item)
  end

  
  def test_destroy
    Factory.create(:item)
    item = Item.first
    delete :destroy, :id => item.name
    assert_redirected_to items_url
    assert !Item.exists?(item.id)
  end
end
