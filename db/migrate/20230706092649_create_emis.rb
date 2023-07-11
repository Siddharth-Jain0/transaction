class CreateEmis < ActiveRecord::Migration[7.0]
  def change
    create_table :emis do |t|
      t.references :loan
      t.integer :month
      t.decimal :interest
      t.decimal :principal
      t.decimal :closing_balance
      t.decimal :total_payment
      t.timestamps
    end
  end
end
