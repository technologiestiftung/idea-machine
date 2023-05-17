class Roll < ApplicationRecord
  belongs_to :side

  def self.latest_for(die:)
    Roll.where(side: die.sides).order("created_at DESC").first
  end
end
