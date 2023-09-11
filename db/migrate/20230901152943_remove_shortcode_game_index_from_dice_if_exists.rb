class RemoveShortcodeGameIndexFromDiceIfExists < ActiveRecord::Migration[7.0]
  def change
    if index_exists?(:dice, [:shortcode, :game_id])
      remove_index :dice, [:shortcode, :game_id]
    end
  end
end
