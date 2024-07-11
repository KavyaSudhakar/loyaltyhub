class CheckMonthlyRewardsJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      if user.total_points >= 100 && user.transactions.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).exists?
        reward_type = RewardType.find_by(reward_type: 'Free Coffee')
        if reward_type && !user.rewards.where(reward_type: reward_type).exists?
          user.rewards.create(reward_type: reward_type)
        end
      end
    end
  end
end
