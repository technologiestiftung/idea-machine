class Die < ApplicationRecord
  has_many :sides, dependent: :destroy
  has_many :rolls, through: :sides

  validates :title, presence: true
  validates :shortcode, presence: true, uniqueness: true
end
