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
    if !params[:loan][:principal].present? || !params[:loan][:time].present?
      flash[:notice] = "Enter Valid Data"
      render :new,status: :unprocessable_entity
    else
      @loan.user_id = current_user.id
      @loan.monthly_rate = (10.0/12.0)/100.0
      @loan.time *= 12
      @loan.status = "pending"
      @loan.emi_amount =(@loan.principal*@loan.monthly_rate*((1 + @loan.monthly_rate)**@loan.time))/(((1+@loan.monthly_rate)**@loan.time)-1)
      if @loan.save
        Turbo::StreamsChannel.broadcast_append_to(:notifications, target: "loantable", html: "<tbody> <tr>
          <td><a href='/loan/#{@loan.id}/emi/index'>#{@loan.id}</a></td>
          <td>#{@loan.principal}</td>
          <td>#{@loan.monthly_rate.round(4)}</td>
          <td>#{@loan.time.round(0)}</td>
          <td>#{@loan.emi_amount.round(2)}</td>
          <td>#{@loan.status} </td>
          </tr></tbody> "
          )
        flash[:notice] = "Applied for Loan"
        redirect_to show_loan_path
      else
        render :new,status: :unprocessable_entity
      end
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

  def refianance
    @emi = Emi.where(loan_id: params[:previous_loan_id],Status: 1).last
    @loan = Loan.find(params[:previous_loan_id])
    @prepayment_amount = @emi.closing_balance + @emi.closing_balance*0.02   
    @loan  = Loan.new
  end
  
  def apply_refianance
      @emi = Emi.find_by(loan_id: params[:loan][:previous_loan_id],Status: 0)
      @loan = Loan.new(loan_params)
    if !params[:loan][:principal].present? || !params[:loan][:time].present?
      flash[:notice] = "Enter Valid Data"
      render :refianance,status: :unprocessable_entity
    elsif @loan.principal < @emi.closing_balance
      flash[:notice] = "Entered Principal should be greater than previous emi closing amount"   
      render :refianance,status: :unprocessable_entity
    else
      @loan.previous_loan_id = params[:loan][:previous_loan_id]
      @loan.user_id = current_user.id
      @loan.monthly_rate = (10.0/12.0)/100.0
      @loan.time *= 12
      @loan.status = "pending"
      @loan.emi_amount =(@loan.principal*@loan.monthly_rate*((1 + @loan.monthly_rate)**@loan.time))/(((1+@loan.monthly_rate)**@loan.time)-1)
      if @loan.save
        flash[:notice] = "Applied for Loan"
        redirect_to show_loan_path
      else
        render :refianance,status: :unprocessable_entity
      end
    end
  end

  private
  def loan_params
    params.require(:loan).permit(:principal,:time)
  end
end
 