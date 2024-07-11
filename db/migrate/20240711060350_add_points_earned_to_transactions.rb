class AddPointsEarnedToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :points_earned, :integer, default: 0, null: false
  end
end
