require "test_helper"

class Public::ForumReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_forum_reports_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_forum_reports_destroy_url
    assert_response :success
  end
end
