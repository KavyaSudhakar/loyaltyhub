class RewardsController < ApplicationController
    def index
      @claimed_rewards = current_user.claimed_rewards
      @available_rewards = RewardType.all
    end

  private

  def reward_params
    params.require(:reward).permit(:reward_type_id, :user_id) 
  end
end