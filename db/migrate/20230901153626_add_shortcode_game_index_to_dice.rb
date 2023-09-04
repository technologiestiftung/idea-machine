class AddShortcodeGameIndexToDice < ActiveRecord::Migration[7.0]
  def change
    unless index_exists?(:dice, [:shortcode, :game_id])
      add_index :dice, [:shortcode, :game_id], unique: true
    end
  end
end
