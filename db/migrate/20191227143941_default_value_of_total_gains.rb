class DefaultValueOfTotalGains < ActiveRecord::Migration[5.2]
  def change
    change_column_default :patrols, :total_gains, 0
  end
end
