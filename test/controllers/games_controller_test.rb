require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "shows games index page" do
    get games_url
    assert_response :success
  end

  test "shows game page" do
    get game_url(games(:summer))
    assert_response :success
  end

  test "shows new game page" do
    get new_game_url
    assert_response :success
  end

  test "creates game" do
    assert_difference("Game.count") do
      post games_url, params: {game: {title: "Test game"}}
    end
  end

  test "rejects game without title" do
    assert_no_difference("Game.count") do
      post games_url, params: {game: {title: nil}}
    end
  end
end
