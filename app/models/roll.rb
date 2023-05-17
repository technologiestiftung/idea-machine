class Roll < ApplicationRecord
  belongs_to :die
  belongs_to :side
end
