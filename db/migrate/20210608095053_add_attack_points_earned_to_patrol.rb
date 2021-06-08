class AddAttackPointsEarnedToPatrol < ActiveRecord::Migration[5.2]
  def change
    add_column :receipts, :attack_points_earned, :integer, default: 0
  end
end
