require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new]" do
    get sessions_new]_url
    assert_response :success
  end

end
