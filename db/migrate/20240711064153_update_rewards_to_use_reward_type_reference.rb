class UpdateRewardsToUseRewardTypeReference < ActiveRecord::Migration[7.1]
  def change
     # Remove the old reward_type column
     remove_column :rewards, :reward_type, :string
  end
end
