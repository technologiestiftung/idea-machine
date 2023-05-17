class CreateDice < ActiveRecord::Migration[7.0]
  def change
    create_table :dice do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
