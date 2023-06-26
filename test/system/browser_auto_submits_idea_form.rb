require "application_system_test_case"

class BrowserAutoSubmitsIdeaTest < ApplicationSystemTestCase
  CREATED_IDEA_TEXT = "A beautiful, new idea"

  test "auto-submits idea form after 3s timeout" do
    stub_idea

    visit "/?timer=3"

    assert_text CREATED_IDEA_TEXT, wait: 10
  end

  test "does not auto-submit idea form with invalid timer" do
    stub_idea

    visit "/?timer=x"

    assert_no_text CREATED_IDEA_TEXT, wait: 10
  end

  private

  def stub_idea
    stubbed_minimal_response_body = {choices: [{message: {content: CREATED_IDEA_TEXT}}]}
    stub_request(:post, "https://api.openai.com/v1/chat/completions")
      .to_return(status: 200, body: stubbed_minimal_response_body.to_json)
  end
end
