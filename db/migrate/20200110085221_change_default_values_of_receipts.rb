class ChangeDefaultValuesOfReceipts < ActiveRecord::Migration[5.2]
  def change
    change_column_default :receipts, :minings_winnings, 0
    change_column_default :receipts, :attack_winnings, 0
    change_column_default :receipts, :defense_losses, 0
    change_column_default :receipts, :base_revenues, 0
    add_column :receipts, :paris_winning, :integer, default: 0
  end
end
