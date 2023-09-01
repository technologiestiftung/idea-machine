require "test_helper"

class GameTest < ActiveSupport::TestCase
  test "accepts game with valid attributes" do
    game = Game.new title: "My game"
    assert game.valid?
    assert_empty game.errors
  end
end
