class RollsController < ApplicationController
  skip_forgery_protection

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
end
