require "test_helper"

class SideTest < ActiveSupport::TestCase
  test "accepts side with valid attributes" do
    side = Side.new(die: dice(:one), title: "Side note", variations: ["sn", "note", "sidenote"], shortcode: 2)
    assert side.valid?
  end

  test "rejects side with invalid attributes" do
    side = Side.new(die: dice(:one), title: nil, shortcode: nil)
    assert_not side.valid?
    assert side.errors[:title].present?
    assert side.errors[:shortcode].present?
  end

  test "creates roll if side is first of die" do
    die = Die.create(title: "focus_group", shortcode: "C", game: games(:fresh))
    side = Side.create(die: die, title: "first", shortcode: "1")

    assert_equal side.rolls.size, 1
  end

  test "does not create roll if die already has rolls from another side" do
    die = Die.create(title: "focus_group", shortcode: "B", game: games(:fresh))
    Side.create(die: die, title: "first", shortcode: "1")

    second_side = Side.create(die: die, title: "second", shortcode: "2")

    assert second_side.rolls.empty?
  end

  test "accepts variations as a string and creates array from it" do
    side = Side.new(die: dice(:one), title: "Side note", variations: "entry", shortcode: 2)
    assert side.valid?
    assert_equal side.variations, ["entry"]
  end

  test "accepts variations as a semicolon-separated string" do
    side = Side.new(die: dice(:one), title: "Side note", variations: "hey;there;vars", shortcode: 2)
    assert side.valid?
    assert_equal side.variations, ["hey", "there", "vars"]
  end
end
