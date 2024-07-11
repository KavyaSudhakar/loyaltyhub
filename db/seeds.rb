# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

reward_types = {
  'Free Coffee' => 'Accumulate 100 points in one calendar monthor receive a Free Coffee in your birthday month.',
  '5% Cash Rebate' => '10 or more transactions with an amount more than $100',
  'Free Movie Tickets' => 'Spending more than $1000 within 60 days of first transaction',
  '4x Airport Lounge Access' => 'Given when a user becomes a gold tier customer',
  '100 points' => 'Given when a user spending is more than $2000  in quarter year'

}

reward_types.each do |reward_type, criteria|
  reward = RewardType.find_or_initialize_by(reward_type: reward_type)
  reward.update(criteria: criteria)
end


LoyaltyTier.create!(name: 'Standard Tier Member', min_points: 0, max_points: 999)
LoyaltyTier.create!(name: 'Gold Tier Member', min_points: 1000, max_points: 4999)
LoyaltyTier.create!(name: 'Platinum Tier Member', min_points: 5000, max_points: 999999999)
