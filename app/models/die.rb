class Die < ApplicationRecord
  VALID_SHORTCODES = ["A", "B", "C"]

  belongs_to :game, optional: true
  has_many :sides, dependent: :destroy
  accepts_nested_attributes_for :sides
  has_many :rolls, through: :sides

  enum :title, {"focus_group" => 0, "topic" => 1, "medium" => 2}

  validates :title, presence: true
  validates :shortcode, inclusion: {in: VALID_SHORTCODES, message: "%{value} is not a valid shortcode. Valid shortcodes are #{VALID_SHORTCODES}"}
  validates :shortcode, presence: true, uniqueness: {scope: :game_id}
end
