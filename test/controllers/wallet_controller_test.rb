require "test_helper"

class WalletControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wallet_index_url
    assert_response :success
  end
end
