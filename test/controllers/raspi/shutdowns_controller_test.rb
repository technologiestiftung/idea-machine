require "test_helper"

class Raspi::ShutdownsControllerTest < ActionDispatch::IntegrationTest
  test "shows shutdown page" do
    get raspi_shutdown_url
    assert_response :success
  end
end
