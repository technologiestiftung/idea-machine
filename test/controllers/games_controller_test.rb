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

  test "creates game and all associated resources" do
    assert_difference -> { Game.count } => 1,
      # We need 3 dice for a game:
      -> { Die.count } => 3,
      # Each die has 6 sides:
      -> { Side.count } => 18,
      # Each die creation automatically creates one initial roll:
      -> { Roll.count } => 3 do
      post games_url, params: valid_nested_game_params
    end
  end

  private

  def valid_nested_game_params
    {
      game: {
        title: "Test game",
        dice_attributes: [
          {
            title: "focus_group",
            shortcode: "A",
            sides_attributes: (1..6).map { |n| {title: "Side #{n}", shortcode: n} }
          },
          {
            title: "topic",
            shortcode: "B",
            sides_attributes: (1..6).map { |n| {title: "Side #{n}", shortcode: n} }
          },
          {
            title: "medium",
            shortcode: "C",
            sides_attributes: (1..6).map { |n| {title: "Side #{n}", shortcode: n} }
          }
        ]
      }
    }
  end
end
