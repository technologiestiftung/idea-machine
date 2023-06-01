class RollsController < ApplicationController
  skip_forgery_protection
  before_action :authenticate

  def create
    die_shortcode, side_shortcode = roll_params[:shortcode].chars
    die = Die.where(shortcode: die_shortcode)
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

  def roll_params
    params.require(:roll).permit(:shortcode)
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(token, Rails.application.credentials.http_token)
    end
  end
end
