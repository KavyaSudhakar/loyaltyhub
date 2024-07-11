class AddCountryToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :country, :string
  end
end
