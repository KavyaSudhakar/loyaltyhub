module TransactionConcern
    extend ActiveSupport::Concern
  
    included do
      has_many :transactions 
  
      def total_points
        transactions.sum(:points_earned)
      end
    end
end
  