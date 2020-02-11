class AddTroopToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :troop_id, :integer
  end
end
