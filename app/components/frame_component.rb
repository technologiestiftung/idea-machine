# frozen_string_literal: true

class FrameComponent < ViewComponent::Base
  def initialize(**args)
    @args = args

    @args[:class] = class_names(
      @args[:class],
      "border border-gray-300",
      "relative",
      "p-7",
      "flex items-center"
    )
  end
end
