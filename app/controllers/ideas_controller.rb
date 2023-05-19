class IdeasController < ApplicationController
  def show
    @idea = Idea.find(params[:id])
  end

  def create
    rolls = Roll.where(id: idea_params[:roll_ids])
    topics = Side.where(id: rolls.pluck(:side_id)).pluck(:title)

    openai_client = OpenAI::Client.new(access_token: Rails.application.credentials.openai_token)

    response = openai_client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{role: "user", content: "Generiere eine lustige Idee für ein innovatives Projekt in der Verwaltunsdigitalisierung. Die Idee soll enthalten: #{topics}. Die Idee soll in einem Satz zusammengefasst werden."}],
        temperature: 0.7
      }
    )

    generated_idea = response.dig("choices", 0, "message", "content")

    @idea = Idea.new(description: generated_idea)

    respond_to do |format|
      if @idea.save
        format.html do
          redirect_to idea_url(@idea),
            notice: "Idea was created"
        end
      else
        # format.json { render json: @roll.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def idea_params
    params.require(:idea).permit(roll_ids: [])
  end
end
