focus_group_die = Die.create! title: "focus_group", shortcode: "A"

FOCUS_GROUPS = [
  {title: "Berliner Bürger:innen"},
  {title: "Wissenschaft", variations: ["Wissenschaftler:innen"]},
  {title: "Verwaltung", variations: ["Verwaltungsangestellte"]},
  {title: "Familien"},
  {title: "Aktivist:innen"},
  {title: "?", variations: ["Benachteiligte Menschen", "Verliebte", "Füchse", "Such dir eine aus"]}
]

FOCUS_GROUPS.each_with_index do |focus_group, idx|
  Side.create! die: focus_group_die, title: focus_group[:title], variations: focus_group[:variations], shortcode: idx + 1
end

topic_die = Die.create! title: "topic", shortcode: "B"

TOPICS = [
  {title: "Klimaschutz"},
  {title: "Biodiversität"},
  {title: "Stadtgrün"},
  {title: "Mobilität & Verkehr"},
  {title: "Wohnen & Energie"},
  {title: "?", variations: ["Kreislaufwirtschaft", "Luft- und Gewässerschutz", "Umweltverschmutzung", "Umweltbildung", "Such dir eins aus"]}
]

TOPICS.each_with_index do |topic, idx|
  Side.create! die: topic_die, title: topic[:title], variations: topic[:variations], shortcode: idx + 1
end

medium_die = Die.create! title: "medium", shortcode: "C"

MEDIA = [
  {title: "Website & App"},
  {title: "Öffentlicher Raum"},
  {title: "Kunstinstallation"},
  {title: "Virtual & Augmented Reality"},
  {title: "IoT"},
  {title: "?", variations: ["Theaterstück", "Bürgerinitiative", "Petition", "Social Media Kanal", "Such dir eins aus"]}
]

MEDIA.each_with_index do |medium, idx|
  Side.create! die: medium_die, title: medium[:title], variations: medium[:variations], shortcode: idx + 1
end
