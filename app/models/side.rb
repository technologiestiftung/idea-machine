class Side < ApplicationRecord
  belongs_to :die

  validates :title, presence: true
end
