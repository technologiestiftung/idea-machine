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
      Du bist ein Ideengenerator für die Mitarbeiter im Jobcenter. Ziel ist es, mit deiner Idee die Gesundheit der spezifischen Zielgruppe zu fördern. Die Idee sollte in maximal drei Sätzen beschrieben werden. Themenfeld: #{topic}, Zielgruppe #{focus_group} Medium: #{medium}. Ein bisschen futuristisch und witzig kann die die Antwort auch sein. Die Antwort soll so formatiert sein: "Titel": Beschreibung
    PROMPT

    TextGenerationService.new(prompt).call
  end
end
