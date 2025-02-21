require "test_helper"

class RoutesControllerTest < ActionDispatch::IntegrationTest
  test "should get info" do
    get routes_info_url
    assert_response :success
  end
end
