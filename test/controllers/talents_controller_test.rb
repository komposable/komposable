require 'test_helper'

class TalentsControllerTest < ActionDispatch::IntegrationTest
  # test "should get show" do
  #   get talent_url(id: "terence-neale")
  #   assert_response :success
  # end

  test "should redirect when talent is not authorized" do
    get talent_url(id: "thirty-two")
    assert_redirected_to root_url
  end
end
