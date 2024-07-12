class CheckMonthlyRewardsJob < ApplicationJob
  queue_as :default

  def perform
    if Time.now == Time.now.end_of_month
      User.find_each do |user|
        qualifies_for_monthly_reward = user.total_points >= 100 &&
                                        user.transactions.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).exists?

        if qualifies_for_monthly_reward
          reward_type = RewardType.find_by(reward_type: 'Free Coffee')
          if reward_type
            user.rewards.create(reward_type: reward_type)
          end
        end
      end
    end
  end
end
