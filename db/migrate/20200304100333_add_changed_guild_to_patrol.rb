class AddChangedGuildToPatrol < ActiveRecord::Migration[5.2]
  def change
    add_column :patrols, :guild_changed, :boolean, default: false
  end
end
