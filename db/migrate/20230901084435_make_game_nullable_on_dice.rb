class MakeGameNullableOnDice < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:dice, :game_id, true)
  end
end
