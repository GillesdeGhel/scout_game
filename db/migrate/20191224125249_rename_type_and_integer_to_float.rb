class RenameTypeAndIntegerToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :buildings, :multiplicator, :float
    rename_column :buildings, :type, :usage
  end
end
