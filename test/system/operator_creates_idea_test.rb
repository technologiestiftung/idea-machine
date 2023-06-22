require "application_system_test_case"

class OperatorCreatesIdeaTest < ApplicationSystemTestCase
  CREATED_IDEA_TEXT = "A beautiful, new idea"

  test "creating an idea via keydown ArrowUp" do
    stub_idea

    visit "/"

    send_keys(:up)

    assert_text CREATED_IDEA_TEXT
  end

  test "creating an idea via keydown ArrowRight" do
    stub_idea

    visit "/"

    send_keys(:right)

    assert_text CREATED_IDEA_TEXT
  end

  test "creating an idea via keydown ArrowDown" do
    stub_idea

    visit "/"

    send_keys(:down)

    assert_text CREATED_IDEA_TEXT
  end

  test "creating an idea via keydown ArrowLeft" do
    stub_idea

    visit "/"

    send_keys(:left)

    assert_text CREATED_IDEA_TEXT
  end

  private

  def stub_idea
    stubbed_minimal_response_body = {choices: [{message: {content: CREATED_IDEA_TEXT}}]}
    stub_request(:post, "https://api.openai.com/v1/chat/completions")
      .to_return(status: 200, body: stubbed_minimal_response_body.to_json)
  end
end
