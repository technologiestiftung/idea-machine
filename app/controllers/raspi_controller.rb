class RaspiController < ApplicationController
  def shutdown
    Raspi.shutdown
  end
end
