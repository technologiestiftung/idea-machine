require "test_helper"

class RollsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @roll = rolls(:one)
    @valid_shortcode = "#{dice(:one).shortcode}#{sides(:one).shortcode}"
    @invalid_shortcode = "#{dice(:one).shortcode}#{sides(:two).shortcode}" # Invalid because side does not belong to die
  end

  test "creates roll" do
    assert_difference("Roll.count") do
      post rolls_url, params: {roll: {shortcode: @valid_shortcode}}, as: :json
    end
  end

  test "responds with status code :created after creation" do
    post rolls_url, params: {roll: {shortcode: @valid_shortcode}}, as: :json
    assert_response :created
  end

  test "responds with status code :unprocessable_entity after unprocessable creation attempt" do
    post rolls_url, params: {roll: {shortcode: @invalid_shortcode}}, as: :json
    assert_response :unprocessable_entity
  end
end
