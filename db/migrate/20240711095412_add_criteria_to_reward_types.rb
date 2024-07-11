class AddCriteriaToRewardTypes < ActiveRecord::Migration[7.1]
  def change
    add_column :reward_types, :criteria, :text
  end
end
