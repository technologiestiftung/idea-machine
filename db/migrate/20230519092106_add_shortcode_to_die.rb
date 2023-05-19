class AddShortcodeToDie < ActiveRecord::Migration[7.0]
  def change
    add_column :dice, :shortcode, :string, null: false
    add_index :dice, :shortcode, unique: true
  end
end
