module LoyaltyTierConcern
    extend ActiveSupport::Concern
  
    included do
      belongs_to :loyalty_tier, optional: false
  
      before_validation :set_default_loyalty_tier, on: :create
  
      # Validations
      validates :loyalty_tier, presence: true 
  
      # Callbacks
      after_save :check_rewards
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
end
  