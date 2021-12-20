require "test_helper"

class TokenboxStoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tokenbox_store_index_url
    assert_response :success
  end
end
