class Game < ApplicationRecord
  has_many :dice, dependent: :destroy

  validates :title, presence: true
end
