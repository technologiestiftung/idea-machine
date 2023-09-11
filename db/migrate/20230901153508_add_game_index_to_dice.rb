class AddGameIndexToDice < ActiveRecord::Migration[7.0]
  def change
    unless index_exists?(:dice, :game_id)
      add_index :dice, :game_id
    end
  end
end
