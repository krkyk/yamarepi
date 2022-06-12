require "test_helper"

class Public::ForumCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_forum_comments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_forum_comments_destroy_url
    assert_response :success
  end
end
