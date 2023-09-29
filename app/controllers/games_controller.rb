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

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html do
          redirect_to game_path(@game), notice: "Willkommen zum neuen Spiel! POSTe Würfelereignisse an den Pfad: #{api_v2_game_rolls_path(@game)}"
        end
      else
        format.html do
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def game_params
    params.require(:game).permit(:title, dice_attributes: [:title, :shortcode, sides_attributes: [:title, :shortcode, :variations]])
  end
end
