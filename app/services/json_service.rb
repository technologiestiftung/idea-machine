require "json"

class JsonService
  def initialize(input)
    @input = input
  end

  def generate
    JSON.generate(@input)
  end
end
