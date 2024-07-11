class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions 
  has_many :rewards
  has_many :reward_types, through: :rewards
  belongs_to :loyalty_tier, optional: false

  before_validation :set_default_loyalty_tier, on: :create
  
  # Callbacks
  after_save :check_rewards

  # Validations
  validates :email, uniqueness: true  
  validates :loyalty_tier, presence: true 

  def claimed_rewards
    rewards.includes(:reward_type).order(created_at: :desc)
  end

  def available_rewards
    RewardType.pluck(:reward_type)
  end

  def total_points
    transactions.sum(:points_earned)
  end

  def spending_in_first_60_days
    first_transaction_date = transactions.order(:created_at).second&.created_at 
    return 0 unless first_transaction_date
  
    transactions.where(created_at: first_transaction_date..(first_transaction_date + 60.days)).sum(:amount)
  end

  def total_spending_last_quarter
    start_of_quarter = Time.current.beginning_of_quarter
    transactions.where('created_at >= ?', start_of_quarter).sum(:amount)
  end

  def check_rewards
    update_loyalty_tier 
    CheckMonthlyRewardsJob.perform_later
    check_birthday_rewards
    check_transaction_count_rewards
    check_new_user_rewards
    check_gold_tier_rewards 
  end

  def update_loyalty_tier
    current_tier = LoyaltyTier.find_by('min_points <= ? AND max_points >= ?', total_points, total_points)
    if current_tier && (loyalty_tier.nil? || loyalty_tier != current_tier)
      self.update_column(:loyalty_tier_id, current_tier.id)
    end
  end

  def loyalty_tier_name
    loyalty_tier ? loyalty_tier.name : 'No Tier Assigned'
  end

  def set_default_loyalty_tier
    self.loyalty_tier ||= LoyaltyTier.find_by(name: 'Standard Tier')
  end

  def check_birthday_rewards
    return unless birthdate.present? && birthdate.month == Time.current.month

    reward_type = RewardType.find_by(reward_type: 'Free Coffee')
    return unless reward_type && !rewards.where(reward_type: reward_type).exists?

    rewards.create(reward_type: reward_type)
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
      if reward_type
        4.times do
          rewards.create(reward_type: reward_type) unless rewards.where(reward_type: reward_type).exists?
        end
      end
    end
  end

  def check_quarterly_bonus_points
    if total_spending_last_quarter > 2000
      self.total_points += 100
      save
    end
  end

  private

  def set_default_loyalty_tier
    self.loyalty_tier ||= LoyaltyTier.find_by(name: 'Standard Tier')
  end
end
