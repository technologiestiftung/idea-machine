class Side < ApplicationRecord
  serialize :variations
  after_initialize do |side|
    side.variations ||= [side.title] if side.variations.blank?
  end
  after_commit :roll_side, on: [:create], if: proc { |side| side.die.rolls.empty? }

  belongs_to :die
  has_many :rolls, dependent: :destroy

  validates :title, :variations, presence: true
  validates :shortcode, presence: true, uniqueness: {scope: :die_id}

  private

  def roll_side
    Roll.create side: self
  end
end
