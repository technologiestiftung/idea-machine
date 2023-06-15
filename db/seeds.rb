focus_group_die = Die.create! title: "Zielgruppe", shortcode: "A"

FOCUS_GROUPS = ["Berliner Bürger:innen", "Kinder", "Verwaltungs-Angestellte", "Senior:innen", "Familien", "Nachtschwärmer"]

FOCUS_GROUPS.each_with_index do |focus_group, idx|
  Side.create! die: focus_group_die, title: focus_group, shortcode: idx + 1
end

topic_die = Die.create! title: "Thema", shortcode: "B"

TOPICS = ["Soziales Miteinander", "Mobilität", "Gesundheit", "Stadtentwicklung", "Wohnen", "Energie und Umwelt"]

TOPICS.each_with_index do |topic, idx|
  Side.create! die: topic_die, title: topic, shortcode: idx + 1
end

medium_die = Die.create! title: "Medium", shortcode: "C"

MEDIA = ["Web-App", "mobile App", "API", "Künstliche Intelligenz", "Virtual Reality", "IoT"]

MEDIA.each_with_index do |medium, idx|
  Side.create! die: medium_die, title: medium, shortcode: idx + 1
end
