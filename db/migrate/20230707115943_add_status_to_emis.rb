class AddStatusToEmis < ActiveRecord::Migration[7.0]
  def change
    add_column :emis, :status, :integer,default:0
  end
end
