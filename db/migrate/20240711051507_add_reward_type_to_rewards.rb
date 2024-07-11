class AddRewardTypeToRewards < ActiveRecord::Migration[7.1]
  def change
    add_reference :rewards, :reward_type, null: false, foreign_key: true
  end
end
