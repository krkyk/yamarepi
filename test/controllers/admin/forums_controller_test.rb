require "test_helper"

class Admin::ForumsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_forums_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_forums_show_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_forums_destroy_url
    assert_response :success
  end
end
