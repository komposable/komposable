require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clients_url
    assert_response :success
  end
end
