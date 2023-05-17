require "test_helper"

class RollTest < ActiveSupport::TestCase
  test "accepts roll with valid attributes" do
    roll = Roll.new(die: dice(:one), side: sides(:one))
    assert roll.valid?
  end
end
