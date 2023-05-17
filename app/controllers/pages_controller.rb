class PagesController < ApplicationController
  def home
    @latest_rolls = []
    Die.all.each do |die|
      @latest_rolls << Roll.latest_for(die: die)
    end
  end
end
