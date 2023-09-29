require "test_helper"

class RaspiControllerTest < ActionDispatch::IntegrationTest
  test "shows shutdown page" do
    get raspi_shutdown_url
    assert_response :success
  end
end
