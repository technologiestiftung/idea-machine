require "test_helper"

class SideTest < ActiveSupport::TestCase
  test "accepts side with valid attributes" do
    side = Side.new(die: dice(:one), title: "Side note", shortcode: 2)
    assert side.valid?
  end

  test "rejects side with invalid attributes" do
    side = Side.new(die: dice(:one), title: nil, shortcode: nil)
    assert_not side.valid?
    assert side.errors[:title].present?
    assert side.errors[:shortcode].present?
  end
end
