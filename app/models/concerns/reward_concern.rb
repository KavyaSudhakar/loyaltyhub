module RewardConcern
  extend ActiveSupport::Concern

  include PointsConcern 

  included do
    has_many :rewards
    has_many :reward_types, through: :rewards
  end

  def claimed_rewards
    rewards.includes(:reward_type).order(created_at: :desc)
  end

  def available_rewards
    RewardType.pluck(:reward_type)
  end

  def check_rewards
    update_loyalty_tier
    CheckMonthlyRewardsJob.perform_later
    check_birthday_rewards
    check_transaction_count_rewards
    check_new_user_rewards
    check_gold_tier_rewards
    check_quarterly_bonus_points
  end

  def check_birthday_rewards
    return unless birthdate.present? && birthdate.month == Time.current.month
    reward_type = RewardType.find_by(reward_type: 'Free Coffee')
    if reward_type && !rewards.where(reward_type: reward_type, created_at: Time.current.beginning_of_year..Time.current.end_of_year).exists?
      rewards.create(reward_type: reward_type)
    end
  end

  def check_transaction_count_rewards
    if transactions.where('amount > ?', 100).count >= 10
      reward_type = RewardType.find_by(reward_type: '5% Cash Rebate')
      if reward_type && !rewards.where(reward_type: reward_type).exists?
        rewards.create(reward_type: reward_type)
      end
    end
  end

  def check_new_user_rewards
    if created_at >= 60.days.ago && spending_in_first_60_days > 1000
      reward_type = RewardType.find_by(reward_type: 'Free Movie Tickets')
      if reward_type && !rewards.where(reward_type: reward_type).exists?
        rewards.create(reward_type: reward_type)
      end
    end
  end

  def check_gold_tier_rewards
    if loyalty_tier&.name == 'Gold'
      reward_type = RewardType.find_by(reward_type: '4x Airport Lounge Access')
      if reward_type && !rewards.where(reward_type: reward_type).exists?
        rewards.create(reward_type: reward_type)
      end
    end
  end

  def check_quarterly_bonus_points
    if total_spending_last_quarter > 2000
      reward_type = RewardType.find_by(reward_type: '100 points')
      if reward_type && !rewards.where(reward_type: reward_type).exists?
        rewards.create(reward_type: reward_type)
      end
    end
  end
end
