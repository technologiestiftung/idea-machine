require "test_helper"

class Api::V1::RollsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @authorization = "Bearer #{Rails.application.credentials.http_token}"
  end

  test "responds with status code :bad_request for now unsupported route" do
    post api_v1_rolls_url, headers: {Authorization: @authorization}, as: :json
    assert_response :bad_request
  end
end
