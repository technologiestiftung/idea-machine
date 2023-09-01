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
end
