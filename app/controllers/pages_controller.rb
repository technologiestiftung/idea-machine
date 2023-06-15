class PagesController < ApplicationController
  def home
    @latest_rolls = []
    Die.all.each do |die|
      latest_roll = Roll.latest_for(die: die)
      @latest_rolls << latest_roll unless latest_roll.blank?
    end
  end
end
