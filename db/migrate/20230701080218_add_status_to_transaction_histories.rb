class AddStatusToTransactionHistories < ActiveRecord::Migration[7.0]
  def change
    add_column :transaction_histories, :status, :string
    add_column :transaction_histories, :option, :string
  end
end
