class Raspi
  def self.shutdown
    Turbo::StreamsChannel.broadcast_replace_to :shutdowns,
      target: "shutdowns-listener",
      partial: "raspi/shutdown_trigger"
  end
end
