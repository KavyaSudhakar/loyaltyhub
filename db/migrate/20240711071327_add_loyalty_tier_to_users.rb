class AddLoyaltyTierToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :loyalty_tier,  foreign_key: true
  end
end
