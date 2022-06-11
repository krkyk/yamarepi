require "test_helper"

class Public::ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get item_search" do
    get public_items_item_search_url
    assert_response :success
  end
end
