require 'test_helper'

class MobileNavControllerTest < ActionDispatch::IntegrationTest
  test "should get show_sidebar" do
    get mobile_nav_show_sidebar_url
    assert_response :success
  end

end
