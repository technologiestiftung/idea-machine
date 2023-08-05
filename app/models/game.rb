class Game < ApplicationRecord
  include Equipment

  has_many :dice, dependent: :destroy
  has_many :sides, through: :dice
  accepts_nested_attributes_for :dice

  validates :title, presence: true
end
