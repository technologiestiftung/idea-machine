class GamesController < ApplicationController
  def index
    @games = Game.all.limit(100)
  end

  def show
    @game = Game.find(params[:id])

    @latest_rolls = []
    @timer = params[:timer]

    @game.dice.each do |die|
      latest_roll = Roll.latest_for(die: die)
      @latest_rolls << latest_roll unless latest_roll.blank?
    end
  end
end
