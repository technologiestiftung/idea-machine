require "test_helper"

class IdeaGenerationServiceTest < ActiveSupport::TestCase
  setup do
    @valid_sides = Side.limit(3)
  end

  test "generates idea with valid input" do
    stub_successful_openai_response

    idea = IdeaGenerationService.new(@valid_sides).call
    assert idea.present?
  end

  private

  def stub_successful_openai_response
    stubbed_minimal_response_body = {choices: [{message: {content: "A beautiful, new idea"}}]}
    stub_request(:post, "https://api.openai.com/v1/chat/completions")
      .to_return(status: 200, body: stubbed_minimal_response_body.to_json)
  end
end
