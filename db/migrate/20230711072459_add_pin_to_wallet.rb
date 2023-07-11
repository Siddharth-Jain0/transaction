class AddPinToWallet < ActiveRecord::Migration[7.0]
  def change
    add_column :wallets, :pin, :integer,default:1234
  end
end
