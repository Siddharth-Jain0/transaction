class AddBankNameToWallets < ActiveRecord::Migration[7.0]
  def change
    add_column :wallets, :bank_name, :string
  end
end
