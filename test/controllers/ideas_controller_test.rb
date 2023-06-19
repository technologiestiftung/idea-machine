require "test_helper"

class IdeasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @roll_a = rolls(:one)
    @roll_b = rolls(:two)
    @roll_c = rolls(:three)
  end

  test "shows idea" do
    get idea_url(ideas(:one))
    assert_response :success
  end

  test "creates idea" do
    stubbed_minimal_response_body = {choices: [{message: {content: "A beautiful, new idea"}}]}
    stub_request(:post, "https://api.openai.com/v1/chat/completions")
      .to_return(status: 200, body: stubbed_minimal_response_body.to_json)

    assert_difference("Idea.count") do
      post ideas_url, params: {idea: {roll_ids: [@roll_a.id, @roll_b.id, @roll_c.id]}}
    end
  end

  test "fails to create idea when no text is generated" do
    stub_request(:post, "https://api.openai.com/v1/chat/completions")
      .to_return(status: 200, body: {}.to_json)

    post ideas_url, params: {idea: {roll_ids: [@roll_a.id, @roll_b.id, @roll_c.id]}}
    assert_response :unprocessable_entity
  end
end
