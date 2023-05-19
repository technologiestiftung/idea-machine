class Idea < ApplicationRecord
  has_and_belongs_to_many :rolls

  validates :description, presence: true
end
