class IdeaGenerationService
  def initialize(sides)
    @sides = sides
  end

  def call
    focus_group = @sides.find_by(die: Die.focus_group)&.title
    topic = @sides.find_by(die: Die.topic)&.title
    medium = @sides.find_by(die: Die.medium)&.title

    return nil if focus_group.blank? || topic.blank? || medium.blank?

    prompt = "Generiere mir eine neue Produktidee für ein smartes Berlin. Die Idee sollte eine digitale Lösung sein, deren Funktion in einer Zeile beschrieben wird. Zielgruppe ist #{focus_group}, technische Lösung #{medium} und das Themenfeld der Idee ist #{topic}. Ein bisschen futuristisch und witzig kann die die Antwort auch sein."

    openai_client = OpenAI::Client.new(access_token: Rails.application.credentials.openai_token)

    response = openai_client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{role: "user", content: prompt}],
        temperature: 0.7
      }
    )

    response.dig("choices", 0, "message", "content")
  end
end
