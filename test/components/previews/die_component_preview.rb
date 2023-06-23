# frozen_string_literal: true

class DieComponentPreview < ViewComponent::Preview
  def default
    render(DieComponent.new(theme: "topix", id: "666")) do |component|
      component.with_hidden_input_field do
        # here could be a hidden input field
      end
      "Berliner Bürger:innen"
    end
  end
end
