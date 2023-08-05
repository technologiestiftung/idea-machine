module Game::Equipment
  extend ActiveSupport::Concern

  included do
    after_initialize :create_dice, if: :new_record?

    private

    def create_dice
      ["A", "B", "C"].each_with_index do |letter, index|
        dice << Die.new(title: Die.titles.keys[index], shortcode: letter)
      end
    end
  end
end
