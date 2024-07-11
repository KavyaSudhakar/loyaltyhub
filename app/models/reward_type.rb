class RewardType < ApplicationRecord
  has_many :rewards
  
  # validations
  validates :reward_type, presence: true, uniqueness: true
end
