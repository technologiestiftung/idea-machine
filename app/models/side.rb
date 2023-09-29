class Side < ApplicationRecord
  serialize :variations

  after_initialize :normalize_variations

  after_commit :roll_side, on: [:create], if: proc { |side| side.die.rolls.empty? }

  belongs_to :die
  has_many :rolls, dependent: :destroy

  validates :title, :variations, presence: true
  validates :shortcode, presence: true, uniqueness: {scope: :die_id}

  private

  def normalize_variations
    case variations
    when ->(v) { v.blank? }
      self.variations = [title]
    when String
      self.variations = variations.split(";")
    end
  end

  def roll_side
    Roll.create side: self
  end
end
