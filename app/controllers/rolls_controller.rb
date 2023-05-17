class RollsController < ApplicationController
  skip_forgery_protection

  def create
    @roll = Roll.new(roll_params)

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
    params.require(:roll).permit(:side_id)
  end
end
