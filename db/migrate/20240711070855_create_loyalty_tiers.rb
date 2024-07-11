class CreateLoyaltyTiers < ActiveRecord::Migration[7.1]
  def change
    create_table :loyalty_tiers do |t|
      t.string :name
      t.integer :min_points
      t.integer :max_points

      t.timestamps
    end

    add_index :loyalty_tiers, :name, unique: true
  end
end
