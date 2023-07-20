class Loan < ApplicationRecord
    belongs_to :user
    has_many :emis, dependent: :destroy
    validates :principal,presence: true,numericality: {greater_than: 0 , message: "should be no. greater than 0"}
    validates :time,presence: true,numericality: {greater_than: 0 , message: "should be a no. greater than 0"}
    after_update :create_emi
    def create_emi
      loan = self
      @emi = Emi.new()
      @emi.loan_id= loan.id
      @emi.month = 1
      opening_balance = loan.principal
      emi_amount = loan.emi_amount
      monthly_rate = loan.monthly_rate
      @emi.interest = opening_balance*monthly_rate
      @emi.principal = emi_amount-@emi.interest
      @emi.closing_balance = opening_balance-@emi.principal
      @emi.total_payment = @emi.principal + @emi.interest
      @emi.due_date = Date.today
      @emi.save
      for i in 2..loan.time
        @emi2 = Emi.new()
        @emi2.loan_id= loan.id
        @emi2.month = @emi.month + 1
        opening_balance = @emi.closing_balance
        monthly_rate = loan.monthly_rate
        emi_amount = loan.emi_amount
        @emi2.interest = opening_balance*monthly_rate
        @emi2.principal = emi_amount-@emi2.interest
        @emi2.closing_balance = opening_balance-@emi2.principal
        @emi2.total_payment = @emi2.principal + @emi2.interest
        @emi2.due_date = @emi.due_date + 1.months
        @emi2.save
        @emi = @emi2
      end
    end
end
