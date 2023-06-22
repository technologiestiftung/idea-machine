# frozen_string_literal: true

class DieComponent < ViewComponent::Base
  renders_one :hidden_input_field

  DEFAULT_THEME = "neutral"
  THEME_MAPPINGS = {
    "focus_group" => "bg-blue",
    "topic" => "bg-yellow",
    "medium" => "bg-pink",
    DEFAULT_THEME => "bg-gray-300"
  }.freeze
  THEME_OPTIONS = THEME_MAPPINGS.keys

  def initialize(theme: nil, **args)
    @theme = theme
    @args = args

    @args[:class] =
      class_names(
        @args[:class],
        "aspect-[1/1] p-12 rounded-md",
        "flex flex-wrap justify-center items-center text-center",
        "hidden",
        THEME_MAPPINGS[
          fetch_or_fallback(THEME_OPTIONS, @theme, DEFAULT_THEME)
        ]
      )

    @args[:data] = {controller: "appear",
                    transition_enter: "transition ease-in-out duration-700",
                    transition_enter_start: "transform -rotate-180 text-gray-900/0",
                    transition_enter_end: "transform rotate-0 text-gray-900/100",
                    transition_leave_start: "transform rotate-0 text-gray-900/100",
                    transition_leave_end: "transform rotate-180 text-gray-900/0"}
      .merge(@args[:data] || {})
  end

  private

  def fetch_or_fallback(allowed_values, given_value, fallback = nil)
    allowed_values.include?(given_value) ? given_value : fallback
  end
end
