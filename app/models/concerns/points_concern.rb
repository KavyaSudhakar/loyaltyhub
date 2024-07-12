module PointsConcern
    extend ActiveSupport::Concern
  
    included do
      def total_points
        transactions.sum(:points_earned)
      end
  
      def spending_in_first_60_days
        first_transaction_date = transactions.order(:created_at).second&.created_at 
        return 0 unless first_transaction_date
      
        transactions.where(created_at: first_transaction_date..(first_transaction_date + 60.days)).sum(:amount)
      end
  
      def total_spending_last_quarter
        start_of_quarter = Time.current.beginning_of_quarter
        transactions.where('created_at >= ?', start_of_quarter).sum(:amount)
      end
    end
end
  