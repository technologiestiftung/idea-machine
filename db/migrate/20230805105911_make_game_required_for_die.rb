class MakeGameRequiredForDie < ActiveRecord::Migration[7.0]
  def change
    change_column_null :dice, :game_id, false
    remove_index :dice, :shortcode, if_exists: true
    remove_index :dice, :game_id, if_exists: true
    add_index :dice, [:shortcode, :game_id], unique: true, if_not_exists: true
  end
end
