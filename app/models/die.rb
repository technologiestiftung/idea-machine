class Die < ApplicationRecord
  has_many :rolls, dependent: :destroy

  validates :title, presence: true
end
