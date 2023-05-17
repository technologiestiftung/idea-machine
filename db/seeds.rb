focus_group_die = Die.create! title: "Zielgruppe"

FOCUS_GROUPS = ["Verwaltung", "Millenials", "Gen Z", "Politiker", "Alleinerziehende", "Hobbygärtner"]

FOCUS_GROUPS.each do |focus_group|
  Side.create! die: focus_group_die, title: focus_group
end

topic_die = Die.create! title: "Zielgruppe"

TOPICS = ["Bäume", "Parks", "Fahrräder", "Straßenbahn", "Workshop", "Wasser"]

TOPICS.each do |topic|
  Side.create! die: topic_die, title: topic
end

medium_die = Die.create! title: "Zielgruppe"

MEDIA = ["Bäume", "Parks", "Fahrräder", "Straßenbahn", "Workshop", "Wasser"]

MEDIA.each do |medium|
  Side.create! die: medium_die, title: medium
end
