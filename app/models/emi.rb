class Emi < ApplicationRecord
	belongs_to :loan , dependent: :destroy
	enum :status, {unpaid: 0,paid: 1}, prefix: true, scopes: false
	
end
