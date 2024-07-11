class LoyaltyTier < ApplicationRecord
    has_many :users

    # Validations
    validates :min_points, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :max_points, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: :min_points }
end
