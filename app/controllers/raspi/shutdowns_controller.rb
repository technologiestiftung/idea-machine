class Raspi::ShutdownsController < ApplicationController
  def show
    Raspi::Shutdown.new
  end
end
