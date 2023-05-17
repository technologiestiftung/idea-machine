require "test_helper"

class DieTest < ActiveSupport::TestCase
  test "accepts die with valid attributes" do
    die = Die.new(title: "Test title")
    assert die.valid?
  end

  test "rejects die with invalid attributes" do
    die = Die.new(title: nil)
    assert_not die.valid?
  end
end
