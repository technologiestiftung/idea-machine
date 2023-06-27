class AddVariationsToSide < ActiveRecord::Migration[7.0]
  def change
    add_column :sides, :variations, :text
  end
end
