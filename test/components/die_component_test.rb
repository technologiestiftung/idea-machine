# frozen_string_literal: true

require "test_helper"

class DieComponentTest < ViewComponent::TestCase
  test "renders the given content" do
    render_inline(DieComponent.new(theme: "medium")) { "Hello content" }
    assert_text "Hello content"
  end

  test "falls back to default background color without provided theme" do
    render_inline(DieComponent.new(theme: nil))
    assert_selector("div.#{DieComponent::THEME_MAPPINGS[DieComponent::DEFAULT_THEME]}")
  end
end
