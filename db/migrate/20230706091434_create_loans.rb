class CreateLoans < ActiveRecord::Migration[7.0]
  def change
    create_table :loans do |t|
      t.references :user,foreign_key: true
      t.decimal :principal
      t.decimal :monthly_rate
      t.decimal :time
      t.decimal :emi_amount
      t.string :status
      t.timestamps
    end
  end
end
