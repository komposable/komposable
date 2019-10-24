require 'test_helper'

class PresentationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get presentation_url(presentations(:one))
    assert_response :success
  end
end
