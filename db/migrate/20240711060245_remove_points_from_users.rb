class RemovePointsFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :points, :integer
  end
end
