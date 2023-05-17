class RollsController < ApplicationController
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
    params.require(:roll).permit(:die_id, :side_id)
  end
end
