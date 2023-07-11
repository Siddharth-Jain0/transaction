class CreateTransactionHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :transaction_histories do |t|
      t.references :sender
      t.references :reciever
      t.decimal :amount
      t.timestamps
    end
  end
end
