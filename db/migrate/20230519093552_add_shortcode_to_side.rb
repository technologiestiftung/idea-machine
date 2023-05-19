class AddShortcodeToSide < ActiveRecord::Migration[7.0]
  def change
    add_column :sides, :shortcode, :integer, null: false
    add_index :sides, [:shortcode, :die_id], unique: true
  end
end
