require "test_helper"

class IdeaTest < ActiveSupport::TestCase
  test "accepts idea with valid attributes" do
    idea = Idea.new(description: "This is a great idea")
    assert idea.valid?
  end

  test "rejects idea with invalid attributes" do
    idea = Idea.new(description: nil)
    assert_not idea.valid?
  end
end
