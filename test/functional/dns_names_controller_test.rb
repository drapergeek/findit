require 'test_helper'

class DnsNamesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => DnsName.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
 
  
  def test_edit
    get :edit, :id => DnsName.first
    assert_template 'edit'
  end

  def test_destroy
    dns_name = DnsName.first
    delete :destroy, :id => dns_name
    assert_redirected_to dns_names_url
    assert !DnsName.exists?(dns_name.id)
  end
end
