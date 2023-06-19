class ChangeTitleOfDiceToInteger < ActiveRecord::Migration[7.0]
  def change
    remove_column :dice, :title, :string
    add_column :dice, :title, :integer
  end
end
