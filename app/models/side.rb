class Side < ApplicationRecord
  belongs_to :die
  has_many :rolls, dependent: :destroy

  validates :title, presence: true
end
