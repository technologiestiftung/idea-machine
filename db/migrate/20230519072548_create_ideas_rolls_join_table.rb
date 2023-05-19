class CreateIdeasRollsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :ideas, :rolls
  end
end
