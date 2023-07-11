class AddDueDateToEmis < ActiveRecord::Migration[7.0]
  def change
    add_column :emis, :due_date, :date
  end
end
