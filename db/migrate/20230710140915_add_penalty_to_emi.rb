class AddPenaltyToEmi < ActiveRecord::Migration[7.0]
  def change
    add_column :emis, :penalty, :decimal,default:0
  end
end
