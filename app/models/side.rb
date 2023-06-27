class Side < ApplicationRecord
  serialize :variations
  after_initialize do |side|
    side.variations ||= [side.title] if side.variations.blank?
  end

  belongs_to :die
  has_many :rolls, dependent: :destroy

  validates :title, :variations, presence: true
  validates :shortcode, presence: true, uniqueness: {scope: :die_id}
end
