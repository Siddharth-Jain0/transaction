class LoanController < ApplicationController
  def index
    @loans = Loan.all
  end

  def show
    @loans = Loan.where(user_id: current_user.id)
  end

  def new
    @loan =Loan.new
  end

  def create
    @loan = Loan.new(loan_params)
    @loan.user_id = current_user.id
    @loan.monthly_rate = (10.0/12.0)/100.0
    @loan.time *= 12
    @loan.status = "pending"
    @loan.emi_amount =(@loan.principal*@loan.monthly_rate*((1 + @loan.monthly_rate)**@loan.time))/(((1+@loan.monthly_rate)**@loan.time)-1)
    if @loan.save
      flash[:notice] = "Applied for Loan"
      redirect_to show_loan_path
    else
      render :new,status: :unprocessable_entity
    end
  end

  def update
    @loan = Loan.find(params[:format])
    @loan.status = "granted"
    if @loan.save
      redirect_to loan_path
    else 
      render :new,status: :unprocessable_entity
    end
  end 

  private
  def loan_params
    params.require(:loan).permit(:principal,:time)
  end
end
 