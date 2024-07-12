class TransactionsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @transactions = current_user.transactions.order(created_at: :desc).page(params[:page]).per(10)
    end
    
    def new
      @transaction = current_user.transactions.new
    end
  
    def create
      @transaction = current_user.transactions.new(transaction_params)
      if @transaction.save!
        current_user.update_loyalty_tier
        redirect_to transactions_path, notice: 'Transaction created successfully.'
      else
        render :new
      end
    end
  
    private
  
    def transaction_params
      params.require(:transaction).permit(:amount, :country)
    end
end
  