class AddDefaultValueToTurnHoldingParis < ActiveRecord::Migration[5.2]
  def change
    change_column_default :troops, :turns_holding_paris, 0
  end
end
