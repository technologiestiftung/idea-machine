class IdeasController < ApplicationController
  include TextGeneration

  rescue_from NoMethodError, with: :no_rolls_exist

  def show
    @idea = Idea.find(params[:id])
  end

  def create
    rolls = Roll.where(id: idea_params[:roll_ids])
    sides = Side.includes(:die).where(id: rolls.pluck(:side_id))
    focus_group = sides.where(die: {title: "Zielgruppe"}).first.title
    topic = sides.where(die: {title: "Thema"}).first.title
    medium = sides.where(die: {title: "Medium"}).first.title

    generated_idea = generate_text(prompt: "Generiere mir eine neue Produktidee für ein smartes Berlin. Die Idee sollte eine digitale Lösung sein, deren Funktion in einer Zeile beschrieben wird. Zielgruppe ist #{focus_group}, technische Lösung #{medium} und das Themenfeld der Idee ist #{topic}. Ein bisschen futuristisch und witzig kann die die Antwort auch sein.")

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

  def no_rolls_exist
    redirect_to root_path, status: :unprocessable_entity
  end
end
