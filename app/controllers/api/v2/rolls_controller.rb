class Api::V2::RollsController < ApplicationController
  skip_forgery_protection
  skip_before_action :http_basic_authenticate
  before_action :http_token_authenticate
  before_action :set_game

  def create
    die_shortcode, side_shortcode = roll_params[:shortcode]&.chars
    die = @game.dice.where(shortcode: die_shortcode)
    side = Side.where(shortcode: side_shortcode.to_i).where(die: die).first

    @roll = Roll.new(side: side)

    respond_to do |format|
      if @roll.save
        format.json { render json: @roll, status: :created }
      else
        format.json { render json: @roll.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def roll_params
    params.permit(:shortcode)
  end

  def http_token_authenticate
    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(token, Rails.application.credentials.http_token)
    end
  end
end
