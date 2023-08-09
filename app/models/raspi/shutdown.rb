class Raspi::Shutdown
  extend ActiveModel::Callbacks

  define_model_callbacks :initialize

  def initialize
    run_callbacks :initialize
  end

  after_initialize :broadcast_shutdown

  def broadcast_shutdown
    Turbo::StreamsChannel.broadcast_replace_to :shutdowns, target: "shutdowns-listener", partial: "raspi/shutdowns/trigger"
  end
end
