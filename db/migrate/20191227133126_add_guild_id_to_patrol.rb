class AddGuildIdToPatrol < ActiveRecord::Migration[5.2]
  def change
    add_column :patrols, :guild_id, :integer
  end
end
