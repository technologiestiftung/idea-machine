class CreateSides < ActiveRecord::Migration[7.0]
  def change
    create_table :sides do |t|
      t.references :die, null: false, foreign_key: true
      t.string :title, null: false

      t.timestamps
    end
  end
end
