class AddPreviousLoanIdToLoans < ActiveRecord::Migration[7.0]
  def change
    add_column :loans, :previous_loan_id, :integer
  end
end
