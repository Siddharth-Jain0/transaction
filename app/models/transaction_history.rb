class TransactionHistory < ApplicationRecord
  belongs_to :sender, class_name: 'Wallet', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'Wallet', foreign_key: 'reciever_id'
  validates :sender_id, presence: true
  validates :reciever_id, presence:true
  validates :amount,presence: true, numericality: {greater_than: 0 , message: "should be integer and greater than 0"}
  validates :status,presence: true
  validates :option,presence:true
  before_save :update_wallet
  paginates_per 10
  def update_wallet 
    if(self.status == "completed")
      @wallet1 = Wallet.find(sender_id)
      @wallet2 = Wallet.find(reciever_id)
      @wallet1.balance = @wallet1.balance - amount
      @wallet2.balance = @wallet2.balance + amount
      @wallet1.save!
      @wallet2.save!  
    end
  end


end
