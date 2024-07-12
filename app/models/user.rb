class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include LoyaltyTierConcern
  include RewardConcern
  include PointsConcern
  include TransactionConcern

  # Callbacks
  after_save :check_rewards

  # Validations
  validates :email, uniqueness: true  
end
