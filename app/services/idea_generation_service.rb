class IdeaGenerationService
  def initialize(sides)
    @sides = sides
  end

  def call
    focus_group = @sides.find_by(die: Die.focus_group)&.variations&.sample
    topic = @sides.find_by(die: Die.topic)&.variations&.sample
    medium = @sides.find_by(die: Die.medium)&.variations&.sample

    return nil if focus_group.blank? || topic.blank? || medium.blank?

    prompt = <<~PROMPT
      Generiere mir eine neue Produktidee für ein smartes Berlin, deren Funktion
      in einer Zeile beschrieben wird. Themenfeld: #{topic}, Zielgruppe #{focus_group} Medium: #{medium}. Ein bisschen futuristisch und witzig kann die die Antwort auch sein. Die Antwort soll so formatiert sein: "Titel": Beschreibung
    PROMPT

    openai_client = OpenAI::Client.new(access_token: Rails.application.credentials.openai_token)

    response = openai_client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{role: "user", content: prompt}],
        temperature: 1
      }
    )

    response.dig("choices", 0, "message", "content")
  end
end
