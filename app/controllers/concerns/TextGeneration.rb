module TextGeneration
  extend ActiveSupport::Concern

  def generate_text(prompt:)
    openai_client = OpenAI::Client.new(access_token: Rails.application.credentials.openai_token)

    response = openai_client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{role: "user", content: prompt}],
        temperature: 0.7
      }
    )

    response.dig("choices", 0, "message", "content")
  end
end
