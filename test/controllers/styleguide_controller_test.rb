require 'test_helper'

class StyleguideControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get styleguide_url
    assert_response :success
  end
end
