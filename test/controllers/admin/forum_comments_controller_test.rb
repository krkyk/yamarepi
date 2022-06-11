require "test_helper"

class Admin::ForumCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_forum_comments_destroy_url
    assert_response :success
  end
end
