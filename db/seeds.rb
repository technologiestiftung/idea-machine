focus_group_die = Die.create! title: "Zielgruppe", shortcode: "A"

FOCUS_GROUPS = ["Verwaltung", "Millenials", "Gen Z", "Politiker", "Alleinerziehende", "Hobbygärtner"]

FOCUS_GROUPS.each_with_index do |focus_group, idx|
  Side.create! die: focus_group_die, title: focus_group, shortcode: idx + 1
end

topic_die = Die.create! title: "Thema", shortcode: "B"

TOPICS = ["Bäume", "Parks", "Fahrräder", "Straßenbahn", "Müll", "Wasser"]

TOPICS.each_with_index do |topic, idx|
  Side.create! die: topic_die, title: topic, shortcode: idx + 1
end

medium_die = Die.create! title: "Medium", shortcode: "C"

MEDIA = ["App", "Website", "Chatbot", "API", "Workshop", "Prototyp"]

MEDIA.each_with_index do |medium, idx|
  Side.create! die: medium_die, title: medium, shortcode: idx + 1
end
