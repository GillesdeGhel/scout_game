class AddEventToReceipt < ActiveRecord::Migration[5.2]
  def change
    add_column :receipts, :event, :string
  end
end
