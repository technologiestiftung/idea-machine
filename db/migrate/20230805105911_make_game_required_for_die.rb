class MakeGameRequiredForDie < ActiveRecord::Migration[7.0]
  def change
    change_column_null :dice, :game_id, false
    remove_index :dice, :shortcode
    remove_index :dice, :game_id
    add_index :dice, [:shortcode, :game_id], unique: true
  end
end
