require 'test_helper'

class ArtProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get art_projects_url
    assert_response :success
  end

  test "should get show" do
    get art_project_url(id: "matt-pyke")
    assert_response :success
  end
end
