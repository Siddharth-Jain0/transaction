class WalletController < ApplicationController
  def index
  end

  def show
    @wallet = Wallet.find_by(user_id: current_user.id)
  end
  
  def set_pin
    @wallet = Wallet.find_by(user_id: current_user.id)
  end

  def update
    @wallet = Wallet.find_by(user_id: current_user.id)
    @wallet.pin = params[:wallet][:pin]
    if @wallet.save
      flash[:notice] = "Pin set Successfully"      
      redirect_to root_path
    else
      flash[:notice] = "Enter Valid pin"
      redirect_to set_pin_path
    end
  end
end
