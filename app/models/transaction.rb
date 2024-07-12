class Transaction < ApplicationRecord
  belongs_to :user

  before_save :calculate_points
  after_save :update_user_rewards

  # Validations
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :country, presence: true

  def calculate_points
    self.points_earned = (amount / 100).floor * 10

    if country != 'america' 
      self.points_earned *= 2
    end
  end

  def update_user_rewards
    user.check_rewards
  end
end
