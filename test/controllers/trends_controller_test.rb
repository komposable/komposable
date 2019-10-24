require 'test_helper'

class TrendsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get trend_url(id: "fake-fakations")
    assert_response :success
  end
end
