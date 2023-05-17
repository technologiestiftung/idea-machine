require "test_helper"

class SideTest < ActiveSupport::TestCase
  test "accepts side with valid attributes" do
    side = Side.new(die: dice(:one), title: "Side note")
    assert side.valid?
  end

  test "rejects side with invalid attributes" do
    side = Side.new(die: dice(:one), title: nil)
    assert_not side.valid?
  end
end
