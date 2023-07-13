class TransactionHistoriesController < ApplicationController
  
  def send_money
    @wallet = Wallet.find_by(user_id: current_user.id)
    @transaction = TransactionHistory.new   
  end 
   
  def create
    @transaction = TransactionHistory.new(tra_params)
    if !params[:transaction_history][:amount].present? || !params[:transaction_history][:upi].present? || !User.find_by(upi: params[:transaction_history][:upi] ).present?
      flash[:notice] = "Transaction Failed .Enter Valid Credentials"
      redirect_to send_money_path
    else
      @transaction.sender_id = current_user.id
      @transaction.reciever_id = User.find_by(upi: params[:transaction_history][:upi] ).id
      @transaction.status = "completed"
      @transaction.option = "send"
      @wallet1 =Wallet.find(current_user.id)
      if @wallet1.pin == params[:transaction_history][:pin].to_i
        if @wallet1.balance < @transaction.amount 
          flash[:notice] = "Transaction Failed . Insufficient Balance"
          redirect_to show_balance_path
        elsif @transaction.save
          flash[:notice] = "Transaction Successful"
          if params[:transaction_history][:loan_id].present?
            @loan = Loan.find(params[:transaction_history][:loan_id])
            @loan.status = "granted"
            @loan.save
            flash[:notice] = "Loan Granted"
          end
          if params[:transaction_history][:emi_id].present?
            @emi = Emi.find(params[:transaction_history][:emi_id])
            @emi.status = 1
            @emi.save
            flash[:notice] = "Emi paid Successfully"      
          end
          redirect_to root_path 
        else
          flash[:notice] = "Transaction Failed .Enter Valid Credentials"
          redirect_to send_money_path
        end
      else
        flash[:notice] = "Incorrect Pin.Transaction Failed"
        redirect_to send_money_path          
      end
    end
  end
  
  def verify
    @user = User.find_by(upi: params[:upi])
  end

  def request_money
    @wallet = Wallet.find_by(user_id: current_user.id)
    @transaction = TransactionHistory.new
  end
  
  def give
    @transaction = TransactionHistory.new(tra_params)
    if !params[:transaction_history][:amount].present? || !params[:transaction_history][:upi].present?
      flash[:notice] = "Transaction Failed .Enter Valid Credentials"
      render request_money_path
    else
      @transaction.reciever_id = current_user.id
      @transaction.sender_id = User.find_by(upi: params[:transaction_history][:upi] ).id
      @transaction.option = "request"
      @transaction.status = "pending"
      if @transaction.save
        flash[:notice] = "Request send Successfully"
        redirect_to root_path  
      else
        render :request_money, status: :unprocessable_entity
      end
    end
  end
  
  def show_requests
    @transactions = TransactionHistory.where(status:"pending",sender_id: current_user.id ,option:"request")
  end

  def cancel
    @transaction = TransactionHistory.find(params[:transaction_id])
    @transaction.update(status:"failed")
    flash[:notice] = "Transaction Canceled Successfully"
    redirect_to show_request_path
  end
  
  def edit
    @transaction = TransactionHistory.find(params[:transaction_id])
  end
  
  def update
    @user = User.find(current_user.id)
    @wallet = Wallet.find_by(user_id: current_user.id)
    @transaction = TransactionHistory.find(params[:user][:id])
    if(@wallet.balance >= @transaction.amount)
      @transaction.status = "completed"
      if @transaction.save
        flash[:notice] = "Transaction Successful"
        redirect_to show_balance_path  
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def show_transactions
    @transactions = TransactionHistory.where("(sender_id = ?) or reciever_id = ?", current_user.id, current_user.id).order(:id).reverse_order.paginate(:page => params[:page], :per_page => 10)   
  end

  def specific_transactions
    if params[:notice]=="none"
      @transactions = TransactionHistory.where("(sender_id = ?) or reciever_id = ?", current_user.id, current_user.id).order(:id).reverse_order  
    else 
      @transactions = TransactionHistory.where("((sender_id = ? ) or reciever_id = ?) and status = ?", current_user.id,current_user.id,params[:status]).order(:id).reverse_order  
    end
    respond_to do|format|
      format.html
      format.turbo_stream
    end
  end

  def search
    if params[:find] == ""
      @transactions = TransactionHistory.where("(sender_id = ?) or reciever_id = ?", current_user.id, current_user.id).order(:id).reverse_order  
    else
      keyword = params[:find] 
      @transactions = TransactionHistory.joins(sender: :user).where("(sender_id = ?) or reciever_id = ?", current_user.id, current_user.id).where("'user.name' LIKE ? OR amount LIKE ? OR status LIKE ? OR option LIKE ?","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%")
    end
  end

  private 
  def tra_params
    params.require(:transaction_history).permit(:amount)
  end
end
