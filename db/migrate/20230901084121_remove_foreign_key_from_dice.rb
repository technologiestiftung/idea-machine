class RemoveForeignKeyFromDice < ActiveRecord::Migration[7.0]
  def change
    if foreign_key_exists?(:dice, :games)
      remove_foreign_key :dice, :games
    end
  end
end
