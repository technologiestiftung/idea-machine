require "test_helper"

class Api::V2::RollsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = games(:summer)
    @roll = rolls(:one)
    @valid_shortcode = "#{dice(:one).shortcode}#{sides(:one).shortcode}"
    @invalid_shortcode = "#{dice(:one).shortcode}#{sides(:two).shortcode}" # Invalid because side does not belong to die
    @authorization = "Bearer #{Rails.application.credentials.http_token}"
  end

  test "creates roll" do
    assert_difference("Roll.count") do
      post api_v2_game_rolls_url(@game), params: {shortcode: @valid_shortcode}, headers: {Authorization: @authorization}, as: :json
    end
  end

  test "responds with status code :created after creation" do
    post api_v2_game_rolls_url(@game), params: {shortcode: @valid_shortcode}, headers: {Authorization: @authorization}, as: :json
    assert_response :created
  end

  test "responds with status code :unprocessable_entity after unprocessable creation attempt" do
    post api_v2_game_rolls_url(@game), params: {shortcode: @invalid_shortcode}, headers: {Authorization: @authorization}, as: :json
    assert_response :unprocessable_entity
  end
end
