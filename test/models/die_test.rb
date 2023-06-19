require "test_helper"

class DieTest < ActiveSupport::TestCase
  test "accepts die with valid attributes" do
    die = Die.new(title: 1, shortcode: "X")
    assert die.valid?
  end

  test "rejects die with invalid attributes" do
    die = Die.new(title: nil, shortcode: nil)

    assert_not die.valid?
    assert die.errors[:title].present?
    assert die.errors[:shortcode].present?
  end
end
