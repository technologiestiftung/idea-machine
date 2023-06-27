# frozen_string_literal: true

class SpinnerComponent < ViewComponent::Base
  def initialize(**args)
    @args = args
    @args[:class] = class_names(@args[:class], "text-gray-900", "-ml-1 mr-3 h-6 w-6", "animate-spin")
    @args["viewBox"] = "0 0 24 24"
    @args[:fill] = "none"
    @args[:xmlns] = "http://www.w3.org/2000/svg"
  end
end
