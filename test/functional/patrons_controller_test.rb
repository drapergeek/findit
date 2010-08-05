require 'test_helper'

class PatronsControllerTest < ActionController::TestCase
  def setup
    login
  end
  
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Patron.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_edit
    get :edit, :id => Patron.first
    assert_template 'edit'
  end
  
  def test_destroy
    patron = Patron.first
    delete :destroy, :id => patron
    assert_redirected_to patrons_url
    assert !Patron.exists?(patron.id)
  end
  
  test "can add a purchase to a patron" do
    assert_difference('patrons(:ironman).services.count', 2) do
        post :add_service , {:patron=>patrons(:ironman), :service_selection=>Service.first }
            assert_redirected_to patrons(:ironman)
        post :add_service , {:patron=>patrons(:ironman), :service_selection=>services(:summertowelservice) }
            assert_redirected_to patrons(:ironman)
    end
  end
  
  test "can show the patrons check in page" do
    get :check_in
    assert_template 'check_in'
  end
  
  test "can find a patron based on a passport" do
    get :show, :passport=>454545454
    assert_template 'show'
  end
  
  test "not found patron by passport redirects to check in" do
    get :show, :passport=>1232141414130999
    assert_equal flash[:error],"There was no patron found with that passport number"
    assert_redirected_to :root
  end
end
