class RemoveShortcodeIndexFromDice < ActiveRecord::Migration[7.0]
  def change
    if index_exists?(:dice, :shortcode)
      remove_index :dice, :shortcode
    end
  end
end
