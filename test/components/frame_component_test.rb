# frozen_string_literal: true

require "test_helper"

class FrameComponentTest < ViewComponent::TestCase
  test "renders the given content" do
    render_inline(FrameComponent.new) { "Hello content" }
    assert_text "Hello content"
  end
end
