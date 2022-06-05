require "test_helper"

class Public::AttentionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_attentions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_attentions_destroy_url
    assert_response :success
  end
end
