class Wallet < ApplicationRecord
	belongs_to :user
	has_many :transaction_histories ,class_name:'Wallet'
	validates :user_id,presence: true
	validates :balance,presence: true
	validates :pin,presence: true, length: {is: 4}
end
