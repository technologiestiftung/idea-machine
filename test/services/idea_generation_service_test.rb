require "test_helper"

class IdeaGenerationServiceTest < ActiveSupport::TestCase
  setup do
    @valid_sides = Side.limit(3)
    @invalid_sides = dice(:unused).sides
  end

  test "generates idea with valid input" do
    stub_successful_openai_response

    idea = IdeaGenerationService.new(@valid_sides).call
    assert idea.present?
  end

  test "rejects generating an idea if unused sides are passed" do
    idea = IdeaGenerationService.new(@invalid_sides).call
    assert idea.blank?
  end

  private

  def stub_successful_openai_response
    stubbed_minimal_response_body = {choices: [{message: {content: "A beautiful, new idea"}}]}
    stub_request(:post, "https://api.openai.com/v1/chat/completions")
      .to_return(status: 200, body: stubbed_minimal_response_body.to_json)
  end
end
