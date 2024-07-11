class Reward < ApplicationRecord
    belongs_to :user
    belongs_to :reward_type

    # Validations
    validates :reward_type, presence: true
end
