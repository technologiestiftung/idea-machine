class Idea < ApplicationRecord
  validates :description, presence: true
end
