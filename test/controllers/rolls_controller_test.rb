require "test_helper"

class RollsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @roll = rolls(:one)
  end

  test "creates roll" do
    assert_difference("Roll.count") do
      post rolls_url, params: {roll: {side_id: @roll.side_id}}, as: :json
    end
  end

  test "responds with status code :created after creation" do
    post rolls_url, params: {roll: {side_id: @roll.side_id}}, as: :json
    assert_response :created
  end

  test "responds with status code :unprocessable_entity after unprocessable creation attempt" do
    post rolls_url, params: {roll: {side_id: nil}}, as: :json
    assert_response :unprocessable_entity
  end
end
