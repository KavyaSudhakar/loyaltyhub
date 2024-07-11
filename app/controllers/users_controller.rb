class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @user.update_loyalty_tier
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :birthdate, :password, :password_confirmation, :current_password, :loyalty_tier_id)
  end
end
