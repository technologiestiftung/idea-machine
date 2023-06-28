require "test_helper"

class TextGenerationServiceTest < ActiveSupport::TestCase
  RETURNED_TEXT = "lorem ipsum"

  test "generates text" do
    stub_successful_openai_response

    text = TextGenerationService.new("gimme text").call
    assert_equal text, RETURNED_TEXT
  end

  test "returns nil when OpenAI API sends error" do
    stub_unsuccessful_openai_response

    text = TextGenerationService.new("gimme text").call

    assert_nil text
  end

  private

  def stub_successful_openai_response
    stubbed_response_body = {choices: [{message: {content: RETURNED_TEXT}}]}
    stub_request(:post, "https://api.openai.com/v1/chat/completions")
      .to_return(status: 200, body: stubbed_response_body.to_json)
  end

  def stub_unsuccessful_openai_response
    stubbed_response_body = {error:
      {message: "Incorrect API key provided: *********. You can find your API key at https://platform.openai.com/account/api-keys.",
       type: "invalid_request_error",
       param: nil,
       code: "invalid_api_key"}}
    stub_request(:post, "https://api.openai.com/v1/chat/completions")
      .to_return(status: 401, body: stubbed_response_body.to_json)
  end
end
