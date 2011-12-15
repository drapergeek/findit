require 'test_helper'

class InstallationsControllerTest < ActionController::TestCase
 test "uninstall software" do
   item = Factory(:item)
   software = Factory(:software)
   installation = Installation.create(:item => item, :software => software)
   get :uninstall_software, :software => software, :item => item
   assert_redirected_to item_url(item)
 end
end
