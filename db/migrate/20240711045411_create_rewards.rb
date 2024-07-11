class CreateRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :rewards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :reward_type, null: false
      
      t.timestamps
    end
  end
end
