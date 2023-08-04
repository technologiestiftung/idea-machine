class Game < ApplicationRecord
  has_many :dice

  validates :title, presence: true
end
