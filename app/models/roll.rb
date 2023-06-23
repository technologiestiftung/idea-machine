class Roll < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :side
  has_and_belongs_to_many :ideas

  after_create_commit :update_latest_roll

  def self.latest_for(die:)
    Roll.where(side: die.sides).order("created_at DESC").first
  end

  private

  def update_latest_roll
    broadcast_update_to(dom_id(side.die), target: dom_id(side.die), partial: "rolls/roll", locals: {roll: self})
    broadcast_replace_to("idea-stream", target: "idea", partial: "ideas/idea", locals: {idea: Idea.new(description: "Eine Idee für Berlin"), class: "text-gray-400 w-full text-center"})
  end
end
