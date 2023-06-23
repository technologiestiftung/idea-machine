# frozen_string_literal: true

class FrameComponentPreview < ViewComponent::Preview
  def with_text
    render(FrameComponent.new) do
      "Aliquam sit harum deleniti maxime. Distinctio repellat dolore laborum et omnis omnis dolor. Ut rerum veritatis accusamus eos illo sit rerum minus. Eum provident qui quis minima ea dolore beatae ut. Deserunt ut ipsa quis et vel nemo minima magnam. Quo autem dignissimos officia et neque ut quaerat quisquam."
    end
  end

  def with_centered_text
    render(FrameComponent.new) do
      tag.div "Idee wird generiert ...", style: "width:'100%'; text-align:center;"
    end
  end
end
