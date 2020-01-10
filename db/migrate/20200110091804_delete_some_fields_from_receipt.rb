class DeleteSomeFieldsFromReceipt < ActiveRecord::Migration[5.2]
  def change
    remove_column :receipts, :attacking_patrols_ids
    remove_column :receipts, :attacked_city_id
  end
end
