class Die < ApplicationRecord
  has_many :sides, dependent: :destroy
  has_many :rolls, through: :sides

  enum :title, {"focus_group" => 0, "topic" => 1, "medium" => 2}

  validates :title, presence: true
  validates :shortcode, presence: true, uniqueness: true
end
