class IdeasController < ApplicationController
  def show
    @idea = Idea.find(params[:id])
  end

  def create
    rolls = Roll.where(id: idea_params[:roll_ids])
    sides = Side.includes(:die).where(id: rolls.pluck(:side_id))

    generated_idea = IdeaGenerationService.new(sides).call

    redirect_to root_path, status: :unprocessable_entity if generated_idea.blank?

    @idea = Idea.new(description: generated_idea)
    @idea.rolls << rolls

    respond_to do |format|
      if @idea.save
        PrintToPaperJob.perform_later @idea.description

        format.turbo_stream

        format.html do
          redirect_to idea_url(@idea)
        end
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
      end
    end
  end

  private

  def idea_params
    params.require(:idea).permit(roll_ids: [])
  end
end
